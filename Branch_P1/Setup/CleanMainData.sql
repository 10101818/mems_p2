delete from jctContractEqpt 
delete from tblContract
delete from tblContractFile
delete from tblEqptAuditDetail
delete from tblEqptAuditHdr
delete from tblEquipment
delete from tblEquipmentFile
delete from tblSupplier
delete from tblSupplierFile


dbcc checkident ("tblContract",reseed,0)   
dbcc checkident ("tblContractFile",reseed,0)   
dbcc checkident ("tblEqptAuditHdr",reseed,0)   
dbcc checkident ("tblEquipment",reseed,0)  
dbcc checkident ("tblEquipmentFile",reseed,0)   
dbcc checkident ("tblSupplier",reseed,0)   
dbcc checkident ("tblSupplierFile",reseed,0)                 	                  

SELECT 
    t.NAME AS TableName,
    SUM(p.rows) AS [RowCount]
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
WHERE   
    i.index_id <= 1
GROUP BY 
    t.NAME, i.object_id, i.index_id, i.name 
ORDER BY 
       t.Name