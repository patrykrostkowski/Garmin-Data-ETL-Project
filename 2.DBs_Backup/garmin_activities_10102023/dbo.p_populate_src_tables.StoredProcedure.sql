USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_populate_src_tables]
as

declare @cursor cursor;
declare @viewname nvarchar(30);
declare @tablename nvarchar(30);
declare @schemaname nvarchar(15);

begin
    set @cursor = cursor for
    select table_name as viewname, SUBSTRING(table_name, 4, len(table_name)) as tablename, TABLE_SCHEMA as schemaname
    from INFORMATION_SCHEMA.VIEWS
    where TABLE_SCHEMA = 'src'

    open @cursor
    fetch next from @cursor
    into @viewname, @tablename, @schemaname

    while @@FETCH_STATUS = 0
    begin
		--select @viewname;
		--select @tablename;
        exec ('drop table if exists '+@schemaname+'.' + @tablename);
        exec ('select * into '+@schemaname+'.'+ @tablename + ' from '+@schemaname+'.' + @viewname);
		fetch next from @cursor
		into @viewname, @tablename, @schemaname
    end;

    close @cursor;
    deallocate @cursor;
end
GO
