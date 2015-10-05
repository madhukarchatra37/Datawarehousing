CREATE TABLE AllProfiles( id int IDENTITY(1,1) PRIMARY KEY, 
firstName VARCHAR(100),
lastName VARCHAR(100), 
profileID VARCHAR(10),
headline VARCHAR(1000), 
industry VARCHAR(100),
country VARCHAR(10), 
location VARCHAR(100),
currentTitle VARCHAR(100),
currentCompany VARCHAR(100), 
currentTitleStartYear VARCHAR(10),
currentTitleNoOfMonths VARCHAR(10),
 );

 select * from AllProfiles ;
 delete from AllProfiles where profileID='private';
 create table company(ID int IDENTITY(1,1) PRIMARY KEY, company_name varchar(100));
 select * from company;
 create table industry(ID int IDENTITY(1,1) PRIMARY KEY, industry_name varchar(100));
 select * from industry;
 create table employee(ID int IDENTITY(1,1) PRIMARY KEY,first_name varchar(200),last_name varchar(200),headline varchar(200), date varchar(100),year varchar(100));
 select * from employee;
 create table location(ID int IDENTITY(1,1) PRIMARY KEY,location_name varchar(100),country varchar(20));
 select * from location;
 create table position(ID int IDENTITY(1,1) PRIMARY KEY,position_name varchar(100),company_name varchar(100));
 select * from position;
 create table profile(ID int IDENTITY(1,1) PRIMARY KEY,emp_id int,industry_id int,company_id int,position_id int,location_id int,FOREIGN KEY (emp_id) REFERENCES employee(ID),FOREIGN KEY (industry_id) REFERENCES industry(ID),FOREIGN KEY (company_id) REFERENCES company(ID),FOREIGN KEY (position_id) REFERENCES position(ID),FOREIGN KEY (location_id) REFERENCES location(ID));
 select * from profile;

 insert into company (company_name)  select distinct currentCompany from AllProfiles;
 insert into industry(industry_name) select distinct industry from AllProfiles where industry IS NOT NULL;
 insert into location(location_name,country) select distinct a.location,a.country from AllProfiles as a where exists(select b.location,b.country from AllProfiles as b where a.location=b.location);
 insert into position(position_name,company_name) select distinct a.currentTitle,a.currentCompany from AllProfiles as a where exists(select b.currentTitle,b.currentCompany from AllProfiles as b where a.currentTitle=b.currentTitle);
 insert into employee(first_name,last_name,headline,date,year) select distinct a.firstName,a.lastName,a.headline,a.currentTitleNoOfMonths,a.currentTitleStartYear from AllProfiles as a where exists(select b.firstName,b.lastName,b.headline,b.currentTitleNoOfMonths,b.currentTitleStartYear from AllProfiles as b where a.firstName=b.firstName);
 
 select * from employee;
 delete from employee where year IS NULL;
 delete from company where company_name='-';
 delete from industry where industry_name='';



select * from AllProfiles;
select * from profile;
insert into profile (emp_id,industry_id,company_id,position_id,location_id) select f1.ID,f2.ID,f3.ID,f4.ID,f5.ID  from (select e.ID from employee as e,AllProfiles where e.first_name=AllProfiles.firstName and e.last_name=AllProfiles.lastName)as f1,(select industry.ID from industry,AllProfiles where industry.industry_name=AllProfiles.industry) AS f2 ,(select company.ID from company,AllProfiles where company.company_name=AllProfiles.currentCompany) AS f3 ,(select position.ID from position,AllProfiles where position_name=AllProfiles.currentTitle) AS f4 ,(select location.ID from location,AllProfiles where location.location_name=AllProfiles.location) AS f5;
select e.ID from employee as e, AllProfiles where e.first_name=AllProfiles.firstName and e.last_name=AllProfiles.lastName;

insert into profile (emp_id,industry_id,company_id,position_id,location_id)
Select distinct E.ID, I.ID,C.ID, P.ID, L.ID from
employee E left join AllProfiles Ap  on E.first_name =AP.firstName AND E.headline=AP.headline AND E.last_name=AP.lastName AND E.date= AP.currentTitleNoOfMonths AND E.year=AP.currentTitleStartYear
left join industry I on AP.industry=I.industry_name
left join company C on AP.currentCompany=C.company_name
left join position P on AP.currentTitle=P.position_name and AP.currentCompany=P.company_name
left join location L on AP.location=L.location_name;

select e.ID from employee as e, AllProfiles where e.first_name=AllProfiles.firstName and e.last_name=AllProfiles.lastName;
select location.ID from location,AllProfiles where location.location_name=AllProfiles.location;

insert into profile (emp_id,industry_id,company_id,position_id,location_id) values((select e.ID from employee as e,AllProfiles where e.first_name=AllProfiles.firstName and e.last_name=AllProfiles.lastName and e.headline=AllProfiles.headline and e.date=AllProfiles.currentTitleNoOfMonths and e.year=AllProfiles.currentTitleStartYear),(select industry.ID from industry,AllProfiles where industry.industry_name=AllProfiles.industry),(select company.ID from company,AllProfiles where company.company_name=AllProfiles.currentCompany),(select position.ID from position,AllProfiles where position.position_name=AllProfiles.currentTitle and position.company_name=AllProfiles.currentCompany),(select location.ID from location,AllProfiles where location.location_name=AllProfiles.location and location.country=AllProfiles.country));

insert into profile (industry_id) (select id from industry);



