--1
select
	rank() over (order by project.stars desc) as rank,
	project.name,
	project.stars
from
	project

---------------
--2
select
	coder.name,
	Count(project_id) as projects
from
	coder
left outer Join
	users_in_projects on coder.id = users_in_projects.user_id
Where
	coder.name = 'Cody'
group by
	coder.name;
--------------------
--3
select
	project.name as codys_projects
from
	coder
left outer Join
	users_in_projects on coder.id = users_in_projects.user_id
left outer join
	project on project.id = users_in_projects.project_id
Where
	coder.name = 'Cody'
group by
	project.name;
--------------------
--4
select
	rank() over (order by project.stars desc) as rank,
	project.name as codys_projects,
	project.stars
from
	coder
left outer Join
	users_in_projects on coder.id = users_in_projects.user_id
left outer join
	project on project.id = users_in_projects.project_id
Where
	coder.name = 'Cody'
group by
	project.name,
	project.stars
limit 3;
--------------------
--5
SELECT
  rank() over (order by Count(tech.name) desc) as rank,
  project.name as project_name,
  Count(tech.name) as tech_count
FROM
  project
left outer Join
  tech_in_projects on project.id = tech_in_projects.project_id
left outer join
  tech on tech.id = tech_in_projects.tech_id
GROUP BY
  project.name
limit 3;
--------------------
--6
select
	proj_counts.name,
	proj_counts.project_count
from
	(SELECT
		project.name as name,
		Count(project.name) as project_count
	FROM
		project
	group by
		project.name) as proj_counts
where
	proj_counts.project_count > 1;
--------------------
--7
select
	rank() over (order by Count(project_id) desc) as rank,
	project.name,
	Count(project_id) as contributors
from
	project
left outer Join
	users_in_projects on project.id = users_in_projects.project_id
group by
	project.id;
----------------
--8
select
	coder.name,
	Count(project_id) as projects
from
	coder
left outer Join
	users_in_projects on coder.id = users_in_projects.user_id
group by
	coder.name;
----------------
--9
select
	rank() over (order by avg(commits.commit_count) desc) as rank,
	project.name,
	avg(commits.commit_count)
from
	(SELECT
		project_id as project,
		Count(project_id) as commit_count
	FROM
		commit
	group by
		project_id) as commits
left outer join
	project on commits.project = project.id
group by
	project.name
-----------------
--10
select
	avg(average_con.contributors) as average
from

	(select
		Count(project_id) as contributors
	from
		project
	left outer Join
		users_in_projects on project.id = users_in_projects.project_id
	group by
		project.id) as average_con
--------------------
--11
select
	avg(project.stars) as average_stars
from
	project;
--------------------
--12
select
	coder.name as project_contributors
from
	coder
left outer Join
	users_in_projects on coder.id = users_in_projects.user_id
left outer join
	project on project.id = users_in_projects.project_id
Where
	project.name = 'Sentimotion'
group by
	coder.name;
---------------------
--13
select
	rank() over (order by Count(pull_request.user_id) desc) as rank,
	coder.name as project_contributors,
	Count(pull_request.user_id)
from
	coder
left outer Join
	users_in_projects on coder.id = users_in_projects.user_id
left outer join
	project on project.id = users_in_projects.project_id
left outer join
	pull_request on coder.id = pull_request.user_id
Where
	project.name = 'Sentimotion'
group by
	coder.name
limit 1;
-----------------------
--14
Select
	pull_req_accepted.coder as name,
	CAST(pull_req_accepted.accepted_pr as float) / cast(pull_req_total.total_pr as float) as acceptance_rate
from
	(select
		coder.name as coder,
		count(pull_request.accepted) as accepted_pr
	from
		coder
	left outer Join
		pull_request on coder.id = pull_request.user_id
	Where
		pull_request.accepted is TRUE and
		coder.name = 'Kyle'
	group by
		coder.name) as pull_req_accepted,
	(select
		coder.name as coder,
		count(pull_request) as total_pr
	from
		coder
	left outer Join
		pull_request on coder.id = pull_request.user_id
	Where
		coder.name = 'Kyle'
	group by
		coder.name) as pull_req_total
---------------------
--15
select
	tech.name as tech_used
from
	project
left outer Join
	tech_in_projects on project.id = tech_in_projects.project_id
left outer Join
	tech on tech_in_projects.tech_id = tech.id
where
	project.name = 'Sentimotion'
group by
		tech.name
------------------------
--16
select
	tech.name as tech_known
from
	coder
left outer Join
	users_in_projects on coder.id = users_in_projects.user_id
left outer Join
	project on users_in_projects.project_id = project.id
left outer Join
	tech_in_projects on project.id = tech_in_projects.project_id
left outer Join
	tech on tech_in_projects.tech_id = tech.id
where
	coder.name = 'Anthony'
group by
	tech.name
---------------------------
--17
select
	coder.name as user_name,
	Count(commit.project_id)
from
	coder
left outer Join
	commit on coder.id = commit.user_id
left outer join
	project on commit.project_id = project.id
where
	project.name = 'Sentimotion'
group by
	coder.name
---------------------------
--18
select
	rank() over (order by Count(commit.user_id) desc) as rank,
	project.name as projects,
	Count(commit.user_id) as commits_to_project
from
	coder
left outer Join
	commit on coder.id = commit.user_id
left outer join
	project on commit.project_id = project.id
where
	coder.name = 'Anthony'
group by
	project.name
limit 3
--------------------------
--19
select
	project.name,
	commit.date as commit_dates
from
	project
left outer join
	commit on project.id = commit.project_id
where
	project.name = 'Sentimotion'
-------------------------
--20
select
	commit.date as commit_dates,
	coder.name,
	Count(commit.user_id) as number_of_commits
from
	coder
left outer join
	commit on coder.id = commit.user_id
where
	coder.name = 'Anthony'
group by
	commit.date,
	coder.name
