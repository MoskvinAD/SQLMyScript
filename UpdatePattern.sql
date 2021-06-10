CREATE TABLE #DD_CodeTemp (
InstanceID uniqueidentifier,
RowId uniqueidentifier ,
Registrar uniqueidentifier 
)


INSERT INTO #DD_CodeTemp(InstanceID,RowId,Registrar )
Select Osn.InstanceID,Osn.RowId , Osn.Registrar From 
 [dbo].[dvtable_{30eb9b87-822b-4753-9a50-a1825dca1b74}] Osn WITH(NOLOCK) 
 join  [dbo].[dvtable_{30eb9b87-822b-4753-9a50-a1825dca1b74}_extended] as Osn_Ext WITH(NOLOCK) On Osn_Ext.RowID = Osn.RowID
 join [dbo].[dvtable_{91b2c5f7-9324-4cef-9afe-a457c8310f06}] as sysInfo WITH(NOLOCK)  ON sis.InstanceID =  Osn.InstanceID
 where sis.State = '4311B263-99F9-4DE4-93C8-62FB3DE227B7' and sis.Kind = '52914FD1-AE3C-4B1D-877B-789BCDA63313' 
 and Osn_Ext.TypeDocument ='48ED28D2-9362-4C68-9CFB-92E702272A83' and Osn_Ext.Controller is null 

select * from #DD_CodeTemp

update Osn_Ext
SET Osn_Ext.Controller = dd.Registrar
from [dbo].[dvtable_{30eb9b87-822b-4753-9a50-a1825dca1b74}_extended] Osn_Ext
inner join #DD_CodeTemp as dd 
on Osn_Ext.RowID = dd.RowId

update ID
Set ID.ChangeDateTime = GETDATE()
From dvsys_instances_date ID
                join #DD_CodeTemp as dd
                    on dd.InstanceID = ID.InstanceID
