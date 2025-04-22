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
- **Current MDF Moved**: 798 GB (SP_Content_Office_Misc.mdf)
- **Current LDF Moved**: 38 GB (SP_Content_Office_Misc_log.ldf)

---

### Section 2: Increase Drive Size on Azure SQL Servers
**Objective**: Increase drive size for disk D and disk L on two Azure-based SQL Server VMs (`SQL *d11` and `SQL *d22`).

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
- **Source**: `R:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`
- **Destination**: `D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`

**LDF File Path Change**:
- **Source**: `G:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`
- **Destination**: `L:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data`

**Pre-requisites**:
- Ensure there are no active connections to the database.
- Ensure the SQL Server account has access to the new folder paths.

**Steps**:

1. **Remove Database from Availability Group**:
   ```sql
   ALTER AVAILABILITY GROUP [AAG-2] REMOVE DATABASE SP_Content_Office_Misc;
   ```

2. **Modify File Locations for MDF and LDF**:
   ```sql
   ALTER DATABASE SP_Content_Office_Misc
       MODIFY FILE (NAME = SP_Content_Office_Misc,
                    FILENAME = 'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Office_Misc.mdf');

   ALTER DATABASE SP_Content_Office_Misc
       MODIFY FILE (NAME = SP_Content_Office_Misc_log,
                    FILENAME = 'L:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\SP_Content_Office_Misc_log.ldf');
   ```

3. **Take the Database Offline**:
   ```sql
   ALTER DATABASE SP_Content_Office_Misc SET OFFLINE;
   ```

4. **Physically Move MDF and LDF Files**:
   - Cut and paste the MDF file from R drive to D drive.
   - Cut and paste the LDF file from G drive to L drive.

5. **Verify SQL Server Account Access**:
   - Open **SQL Server Configuration Manager**.
   - Right-click the SQL Server service > Properties > Log On.
   - Confirm the service account has NTFS permissions to new paths.

6. **Bring Database Back Online**:
   ```sql
   ALTER DATABASE SP_Content_Office_Misc SET ONLINE;
   ```

7. **Confirm File Paths**:
   ```sql
   SELECT name, physical_name AS NewLocation, state_desc AS Status
   FROM sys.master_files
   WHERE database_id = DB_ID('SP_Content_Office_Misc');
   ```

