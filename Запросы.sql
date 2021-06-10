
	---------------------------------------------------------------------------------------------
	--Количество незавершенных заданий по всем видам документов всех пользователей (в том числе неактивных). Количество отдельно по заданиям
	---------------------------------------------------------------------------------------------
     /*
	Количество незавершенных заданий DV4.5
	*/
	SELECT COUNT(*) AS 'Количество незавершенных заданий DV4.5'
	FROM [dbo].[dvtable_{77C70C13-881A-4534-9704-C4F6B9ACDB0A}] AS MainInfo WITH(NOLOCK)        
	WHERE MainInfo.[ResolutionState] != 3 
	AND MainInfo.[CreationDate] <= '2021-01-01 00:00:00.000'
	
	/*
	[ResolutionState] = Значения:Ошибка = -1, Не активна = 0, К исполнению = 1, В процессе = 2, Исполнена = 3, Отозвана = 4
	*/
	

	--Количество не завершенных: 159611 на момент до 2021-01-01 00:00:00.000
	--Количество(ВСЕГО не завершенных): 160134
	--Количество(ВСЕГО): 1342583
	
	---------------------------------------------------------------------------------------------
	 /*
	Количество незавершенных заданий DV5.x
	*/
	
	SELECT COUNT(*) AS 'Количество незавершенных заданий DV5.x'
	FROM [dbo].[dvtable_{CAC73A35-ABAF-4A57-A7A9-C2006F1C14BC}] AS TaskSystem WITH(NOLOCK) 
		JOIN [dbo].[dvtable_{521B4477-DD10-4F57-A453-09C70ADB7799}] AS TaskState WITH(NOLOCK)
			ON TaskState.[RowID] = TaskSystem.[State]
		JOIN [dbo].[dvtable_{134EA363-F5A8-4B80-B302-B21C954CE983}] AS CurrentPerformers WITH(NOLOCK)
			ON CurrentPerformers.[InstanceID] = TaskSystem.[InstanceID] 
		JOIN [dbo].[dvsys_instances_date] AS InstancesDate WITH(NOLOCK)
			ON InstancesDate.[InstanceID] = TaskSystem.[InstanceID]	          
	WHERE TaskState.[DefaultName] != 'Completed' 
	and  TaskState.[DefaultName] != 'Завершено'
	and InstancesDate.[CreationDateTime] <= '2021-01-01 00:00:00.000'
	
	/*
	TaskState.[DefaultName] = [dbo].[dvtable_{521B4477-DD10-4F57-A453-09C70ADB7799}]
	****Не было в Finished, end
	*/
	--select RowID , DefaultName,BuiltInState from [dbo].[dvtable_{521B4477-DD10-4F57-A453-09C70ADB7799}]
	--ORDER by BuiltInState
	
	
	
	--Количество не завершенных: 207706 на момент до 2021-01-01 00:00:00.000
	--Количество(ВСЕГО не завершенных): 231993
	--Количество(ВСЕГО): 1627861
	
	---------------------------------------------------------------------------------------------
		 /*
	Количество незавершенных Заданий бизнес-процесса
	*/
	
	SELECT COUNT(*) AS 'Количество незавершенных Заданий бизнес-процесса'
	FROM [dbo].[dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] AS WorkflowTask  WITH(NOLOCK)
	JOIN [dbo].[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] AS Performing  WITH(NOLOCK)
			ON Performing.[InstanceID] = WorkflowTask.[InstanceID] 
	JOIN [dbo].[dvsys_instances_date] AS InstancesDate WITH(NOLOCK)
			ON InstancesDate.[InstanceID] = Performing.[InstanceID]	 			
			Where Performing.TaskState != 5
			and  InstancesDate.[CreationDateTime] <= '2021-01-01 00:00:00.000'
	
	/*
	Значения:Неактивно = 0, К исполнению = 1, Не начато = 2, В работе = 3, Отложено = 4, Исполнено = 5, Отказано = 6, Отозвано = 7, Делегировано - не начато = 8, Делегировано - в работе = 9, Делегировано - отложено = 10, Делегировано - к исполнению = 11, 
	*/
	
	
	--Количество не завершенных: 841291 на момент до 2021-01-01 00:00:00.000
	--Количество(ВСЕГО не завершенных): 841795
	--Количество(ВСЕГО): 3756652
	
	---------------------------------------------------------------------------------------------
	
	
	---------------------------------------------------------------------------------------------
	--Количество завершенных, но не удалённых БП в системе
	---------------------------------------------------------------------------------------------
     /*
	
	*/
	SELECT COUNT(*) AS 'Количество завершенных БП'
	FROM [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] AS MainInfo  WITH(NOLOCK) 
	JOIN [dbo].[dvsys_instances_date] AS InstancesDate WITH(NOLOCK)
			ON InstancesDate.[InstanceID] = MainInfo.[InstanceID]	 
	JOIN dbo.dvsys_instances AS DVSysInst  WITH(NOLOCK)
			ON DVSysInst.[InstanceID] = MainInfo.[InstanceID]  		     
	WHERE MainInfo.State = 4 
	and DVSysInst.Deleted != 1
	and InstancesDate.[CreationDateTime] <= '2021-01-01 00:00:00.000'
	
	/*
	[State] = :Остановлен = 0, Активен = 1, Приостановлен = 2, Приостановлен из-за ошибки = 3, Завершен успешно = 4
	*/
	SELECT * from dbo.dvsys_instances

	--Количество завершенных: 1689538 на момент до 2021-01-01 00:00:00.000
	--Количество(ВСЕГО завершенных): 1699360
	--Количество(ВСЕГО): 2449151
	---------------------------------------------------------------------------------------------
	
