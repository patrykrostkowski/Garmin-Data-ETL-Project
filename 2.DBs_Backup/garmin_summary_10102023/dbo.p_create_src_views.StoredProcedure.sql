USE [garmin_summary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--##########################################################################

CREATE procedure [dbo].[p_create_src_views]
as

declare @linkedserver nvarchar(20) = 'garmin_summary'
declare @cursor cursor;
declare @tablename nvarchar(30);
declare @schemaname nvarchar(10);

begin
    set @cursor = cursor for
    select TableName, SchemaName
    from dbo.config
    where IsActive = 'Y'

    open @cursor
    fetch next from @cursor
    into @tablename, @schemaname

    while @@FETCH_STATUS = 0
    begin

        exec ('create or alter view '+@schemaname+'.vw_' + @tablename + ' as select * from openquery('+@linkedserver+',''select * from ' + @tablename + ''')')

        fetch next from @cursor
        into @tablename, @schemaname
    end
    close @cursor;
    deallocate @cursor;
end
GO
