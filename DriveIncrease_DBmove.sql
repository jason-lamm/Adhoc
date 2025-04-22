## SQL Server Maintenance Activities

### Section 1: Increase Drive Size on Azure SQL Servers
**Objective**: Increase drive size for 2 specific drives on 2 Azure-based SQL Servers.

**Steps**:
1. **Identify the VM and the Disk**:
   - Go to Azure Portal > Virtual Machines > Select SQL Server VM.
   - Under “Settings,” go to **Disks**.

2. **Select the Target Disk**:
   - Identify the disk (e.g., `Data` or `Log`) to be expanded.
   - Note the current size and attached drive letter.

3. **Resize the Disk**:
   - Click on the disk name to open disk properties.
   - Click **Size + performance**.
   - Increase the size (e.g., from 256 GB to 512 GB).
   - Click **Save**.

4. **Resize the Volume in Windows**:
   - RDP into the SQL Server.
   - Open **Disk Management** (`diskmgmt.msc`).
   - Right-click the corresponding volume and choose **Extend Volume**.
   - Complete the wizard to extend the partition.

5. **Validate Free Space**:
   - Verify new size using Windows Explorer or `Get-Volume` in PowerShell.

---

### Section 2: Move SQL Database Files (MDF and LDF) to Another Drive

**Pre-requisites**:
- Ensure there are no active connections to the database.
- Ensure the SQL Server account has access to the new folder path.

**Steps**:

1. **Identify Database Files**:
   ```sql
   SELECT name, physical_name AS CurrentLocation
   FROM sys.master_files
   WHERE database_id = DB_ID('YourDatabaseName');
   ```

2. **Modify File Locations**:
   
   ---R:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data    --Source MDF
   ---D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data     --Destination MDF

   ---G:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data    -Source ldf
   ---L:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data    -Destination ldf
   
   ```sql
   ALTER DATABASE YourDatabaseName
       MODIFY FILE (NAME = YourMDFLogicalName,
                    FILENAME = 'NewDrive:\\NewFolder\\YourDatabaseName.mdf');

   ALTER DATABASE YourDatabaseName
       MODIFY FILE (NAME = YourLDFLogicalName,
                    FILENAME = 'NewDrive:\\NewFolder\\YourDatabaseName_log.ldf');
   ```

3. **Take the Database Offline**:
   ```sql
   ALTER DATABASE YourDatabaseName SET OFFLINE;
   ```

4. **Physically Move Files**:
   - Cut and paste the MDF and LDF files from the old location to the new one.

5. **Verify SQL Server Account Access**:
   - Open **SQL Server Configuration Manager**.
   - Right-click the SQL Server service > Properties > Log On.
   - Confirm the service account has NTFS permissions to new path.

6. **Bring Database Back Online**:
   ```sql
   ALTER DATABASE YourDatabaseName SET ONLINE;
   ```

7. **Confirm File Paths**:
   ```sql
   SELECT name, physical_name AS NewLocation, state_desc AS Status
   FROM sys.master_files
   WHERE database_id = DB_ID('YourDatabaseName');
   ```

