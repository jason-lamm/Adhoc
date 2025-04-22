## SQL Server Maintenance Activities

### Section 1: Gather Current Disk and Database File Information
**Objective**: Identify current database file locations before performing changes.

**Steps**:

1. **Identify SQL Database File Locations**:
   ```sql
   SELECT name, physical_name AS CurrentLocation
   FROM sys.master_files
   WHERE database_id = DB_ID('YourDatabaseName');
   ```

2. **Get Logical File Names for Database**:
   ```sql
   USE YourDatabaseName;
   GO
   SELECT name AS LogicalName, physical_name AS PhysicalLocation
   FROM sys.database_files;
   ```

3. **Check for Active Connections**:
   ```sql
   SELECT session_id, login_name, status, host_name, program_name
   FROM sys.dm_exec_sessions
   WHERE database_id = DB_ID('YourDatabaseName');
   ```

**Tracking Goals:**
- **Target MDF Size to Move**: 2,000 GB
- **Current MDF Moved**: 2,140 GB (SP_Content_Office_Misc.mdf + SP_Content_Center_OMH.mdf + SP_Content_Center_CM.mdf)
- **Current LDF Moved**: 173 GB (SP_Content_Office_Misc_log.ldf + SP_Content_Center_OMH_log.ldf + SP_Content_Center_CM_log.ldf)

---

### Section 2: Increase Drive Size on Azure SQL Servers
**Objective**: Sequentially increase drive size for disk D and disk L on two Azure-based SQL Server VMs (`SQL *d11` and `SQL *d22`) while maintaining high availability.

**Notes**:
- These two servers work together in a high availability setup.
- Drive resizing must be performed one server at a time.
- Before resizing a server’s drives, move all availability groups to the opposite node.
- After both resizing tasks are complete:
  - Ensure `AAG-1` is placed on `*d11`.
  - Ensure `AAG-2` is placed on `*d22`.

**Steps**:
1. **Identify the VM and the Disk**:
   - Go to Azure Portal > Virtual Machines > Select `SQL *d11` or `SQL *d22`.
   - Under “Settings,” go to **Disks**.

2. **Select the Target Disk**:
   - Identify the disk D or disk L to be expanded.
   - Note the current size and attached drive letter.

3. **Resize the Disk**:
   - For **disk L**, increase from **P30 (1000 GiB)** to **P40 (2000 GiB)**.
   - For **disk D**, increase from **P50 (4000 GiB)** to **P60 (8000 GiB)**.
   - Click on the disk name to open disk properties.
   - Click **Size + performance**.
   - Select the new size tier.
   - Click **Save**.

4. **Resize the Volume in Windows**:
   - RDP into the SQL Server.
   - Open **Disk Management** (`diskmgmt.msc`).
   - Right-click the corresponding volume and choose **Extend Volume**.
   - Complete the wizard to extend the partition.

5. **Validate Free Space**:
   - Verify new size using Windows Explorer or `Get-Volume` in PowerShell.

---

### Section 3: Move SQL Database Files (MDF and LDF) to New Drives

**Preliminary Step**: Verify that availability group `AAG-2` is PRIMARY on the `*d22` server.  
**Note**: The MDF file will be moved from the R drive to the D drive, and the LDF file from the G drive to the L drive.

**MDF File Path Change**:
- Source: `R:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`
- Destination: `D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`

**LDF File Path Change**:
- Source: `G:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`
- Destination: `L:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`

**Pre-requisites**:
- Ensure there are no active connections to the database.
- Ensure the SQL Server account has access to the new folder paths.

---

#### For `SP_Content_Office_Misc`

1. **Remove from Availability Group**:
   ```sql
   ALTER AVAILABILITY GROUP [AAG-2] REMOVE DATABASE SP_Content_Office_Misc;
   ```

2. **Modify File Locations**:
   ```sql
   ALTER DATABASE SP_Content_Office_Misc
       MODIFY FILE (NAME = SP_Content_Office_Misc,
                    FILENAME = 'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Office_Misc.mdf');

   ALTER DATABASE SP_Content_Office_Misc
       MODIFY FILE (NAME = SP_Content_Office_Misc_log,
                    FILENAME = 'L:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Office_Misc_log.ldf');
   ```

3. **Take Offline**:
   ```sql
   ALTER DATABASE SP_Content_Office_Misc SET OFFLINE;
   ```

4. **Move Files**: Move `.mdf` from R:\ to D:\ and `.ldf` from G:\ to L:\  
5. **Verify SQL Server Access** to new paths  
6. **Bring Online**:
   ```sql
   ALTER DATABASE SP_Content_Office_Misc SET ONLINE;
   ```

7. **Confirm Paths**:
   ```sql
   SELECT name, physical_name AS NewLocation, state_desc
   FROM sys.master_files
   WHERE database_id = DB_ID('SP_Content_Office_Misc');
   ```

8. **Add Back to AG**:
   ```sql
   ALTER AVAILABILITY GROUP [AAG-2] ADD DATABASE SP_Content_Office_Misc;
   ```

---

#### For `SP_Content_Center_OMH`

1. **Remove from Availability Group**:
   ```sql
   ALTER AVAILABILITY GROUP [AAG-2] REMOVE DATABASE SP_Content_Center_OMH;
   ```

2. **Modify File Locations**:
   ```sql
   ALTER DATABASE SP_Content_Center_OMH
       MODIFY FILE (NAME = SP_Content_Center_OMH,
                    FILENAME = 'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Center_OMH.mdf');

   ALTER DATABASE SP_Content_Center_OMH
       MODIFY FILE (NAME = SP_Content_Center_OMH_log,
                    FILENAME = 'L:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Center_OMH_log.ldf');
   ```

3. **Take Offline**:
   ```sql
   ALTER DATABASE SP_Content_Center_OMH SET OFFLINE;
   ```

4. **Move Files**: Move `.mdf` from R:\ to D:\ and `.ldf` from G:\ to L:\  
5. **Verify SQL Server Access**  
6. **Bring Online**:
   ```sql
   ALTER DATABASE SP_Content_Center_OMH SET ONLINE;
   ```

7. **Confirm Paths**:
   ```sql
   SELECT name, physical_name AS NewLocation, state_desc
   FROM sys.master_files
   WHERE database_id = DB_ID('SP_Content_Center_OMH');
   ```

8. **Add Back to AG**:
   ```sql
   ALTER AVAILABILITY GROUP [AAG-2] ADD DATABASE SP_Content_Center_OMH;
   ```

---

#### For `SP_Content_Center_CM`

1. **Remove from Availability Group**:
   ```sql
   ALTER AVAILABILITY GROUP [AAG-2] REMOVE DATABASE SP_Content_Center_CM;
   ```

2. **Modify File Locations**:
   ```sql
   ALTER DATABASE SP_Content_Center_CM
       MODIFY FILE (NAME = SP_Content_Center_CM,
                    FILENAME = 'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Center_CM.mdf');

   ALTER DATABASE SP_Content_Center_CM
       MODIFY FILE (NAME = SP_Content_Center_CM_log,
                    FILENAME = 'L:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Center_CM_log.ldf');
   ```

3. **Take Offline**:
   ```sql
   ALTER DATABASE SP_Content_Center_CM SET OFFLINE;
   ```

4. **Move Files**: Move `.mdf` from R:\ to D:\ and `.ldf` from G:\ to L:\  
5. **Verify SQL Server Access**  
6. **Bring Online**:
   ```sql
   ALTER DATABASE SP_Content_Center_CM SET ONLINE;
   ```

7. **Confirm Paths**:
   ```sql
   SELECT name, physical_name AS NewLocation, state_desc
   FROM sys.master_files
   WHERE database_id = DB_ID('SP_Content_Center_CM');
   ```

8. **Add Back to AG**:
   ```sql
   ALTER AVAILABILITY GROUP [AAG-2] ADD DATABASE SP_Content_Center_CM;
   ```


---

### Summary of Maintenance Activities
This section provides a high-level summary suitable for change request documentation.

1. **Drive Expansion (One Server at a Time)**
   - Shift all availability groups to the opposite server.
   - Resize disk D (from 4TB to 8TB) and disk L (from 1TB to 2TB).
   - Repeat for the second server.
   - Final AAG placement: AAG-1 on *d11, AAG-2 on *d22.

2. **Database File Migration**
   - For each database:
     - Remove it from the availability group.
     - Alter the file path for MDF and LDF.
     - Take the database offline.
     - Physically move the files.
     - Bring the database online.
     - Re-add it to the availability group.

3. **Post-Migration Validation**
   - Confirm correct file paths in `sys.master_files`.
   - Monitor SQL Server and AG health.
   - Validate disk space post-move.
 **Drive Expansion (One Server at a Time)**
   - Shift all availability groups to the opposite server.
   - Resize disk D (from 4TB to 8TB) and disk L (from 1TB to 2TB).
   - Repeat for the second server.
   - Final AAG placement: AAG-1 on *d11, AAG-2 on *d22.

3. **Database File Migration**
   - For each database:
     - Remove it from the availability group.
     - Alter the file path for MDF and LDF.
     - Take the database offline.
     - Physically move the files.
     - Bring the database online.
     - Re-add it to the availability group.

4. **Post-Migration Validation**
   - Confirm correct file paths in `sys.master_files`.
   - Monitor SQL Server and AG health.
   - Validate disk space post-move.

