USE GosGid;
GO

SELECT TOP 5 
    title AS [Название инструкции], 
    views_count AS [Количество просмотров]
FROM dbo.services_instructions
ORDER BY views_count DESC;
GO

SELECT 
    c.course_name AS [Название курса], 
    COUNT(vc.video_id) AS [Кол-во видео], 
    SUM(vc.duration_minutes) AS [Общая длительность (мин)]
FROM dbo.courses c
INNER JOIN dbo.video_courses vc ON c.course_id = vc.course_id
GROUP BY c.course_name
ORDER BY [Общая длительность (мин)] DESC;
GO

SELECT 
    c.course_name AS [Курс без видео], 
    c.difficulty_level AS [Уровень сложности]
FROM dbo.courses c
LEFT JOIN dbo.video_courses vc ON c.course_id = vc.course_id
WHERE vc.video_id IS NULL;
GO

SELECT 
    u.username AS [Имя пользователя], 
    COUNT(st.ticket_id) AS [Кол-во обращений]
FROM dbo.users u
INNER JOIN dbo.support_tickets st ON u.user_id = st.user_id
GROUP BY u.username
HAVING COUNT(st.ticket_id) > 1;
GO

SELECT 
    si.title AS [Инструкция], 
    si.estimated_time_min AS [Время (мин)], 
    sc.category_name AS [Категория]
FROM dbo.services_instructions si
INNER JOIN dbo.service_categories sc ON si.category_id = sc.category_id
WHERE si.estimated_time_min > 30 
  AND sc.category_name IN (N'Налоги и финансы', N'Социальная помощь');
GO

SELECT 
    st.subject AS [Тема обращения],
    u_user.username AS [Заявитель],
    u_admin.username AS [Ответивший админ],
    tr.replied_at AS [Дата ответа]
FROM dbo.support_tickets st
INNER JOIN dbo.users u_user ON st.user_id = u_user.user_id
INNER JOIN dbo.ticket_responses tr ON st.ticket_id = tr.ticket_id
INNER JOIN dbo.users u_admin ON tr.admin_id = u_admin.user_id;
GO

SELECT 
    st.ticket_id AS [ID тикета],
    st.subject AS [Тема],
    st.created_at AS [Создан],
    tr.replied_at AS [Отвечено],
    DATEDIFF(day, st.created_at, tr.replied_at) AS [Дней на ответ]
FROM dbo.support_tickets st
INNER JOIN dbo.ticket_responses tr ON st.ticket_id = tr.ticket_id
ORDER BY [Дней на ответ] DESC;
GO

SELECT 
    title AS [Название], 
    category_id AS [ID категории]
FROM dbo.services_instructions
WHERE LOWER(title) LIKE N'%паспорт%';
GO

SELECT 
    FORMAT(added_at, 'yyyy-MM') AS [Месяц], 
    COUNT(favorite_id) AS [Добавлено в избранное]
FROM dbo.user_favorites
GROUP BY FORMAT(added_at, 'yyyy-MM')
ORDER BY [Месяц];
GO

SELECT 
    r.role_name AS [Роль], 
    COUNT(u.user_id) AS [Количество пользователей]
FROM dbo.user_roles r
LEFT JOIN dbo.users u ON r.role_id = u.role_id
GROUP BY r.role_name;
GO