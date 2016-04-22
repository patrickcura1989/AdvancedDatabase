--
-- Use SQL/XML to create a persistant XML view of relational content
--
create or replace view DEPARTMENT_XML of xmltype
with object id
(
  XMLCAST(XMLQUERY('/Department/Name' passing OBJECT_VALUE returning CONTENT) as VARCHAR2(30))
) 
as
select xmlElement
       (
         "Department",
         xmlAttributes( d.DEPARTMENT_ID as "DepartmentId"),
         xmlElement("Name", d.DEPARTMENT_NAME),
         xmlElement
         (
           "Location",
           xmlForest
           (
              STREET_ADDRESS as "Address", CITY as "City", STATE_PROVINCE as "State",
              POSTAL_CODE as "Zip",COUNTRY_NAME as "Country"
           )
         ),
         xmlElement
         (
           "EmployeeList",
           (
             select xmlAgg
                    (
                      xmlElement
                      (
                        "Employee",
                        xmlAttributes ( e.EMPLOYEE_ID as "employeeNumber" ),
                        xmlForest
                        (
                          e.FIRST_NAME as "FirstName", e.LAST_NAME as "LastName", e.EMAIL as "EmailAddress",
                          e.PHONE_NUMBER as "Telephone", e.HIRE_DATE as "StartDate", j.JOB_TITLE as "JobTitle",
                          e.SALARY as "Salary", m.FIRST_NAME || ' ' || m.LAST_NAME as "Manager"                
                        ),
                        xmlElement ( "Commission", e.COMMISSION_PCT )
                      )
                    )
               from HR.EMPLOYEES e, HR.EMPLOYEES m, HR.JOBS j
              where e.DEPARTMENT_ID = d.DEPARTMENT_ID
                and j.JOB_ID = e.JOB_ID
                and m.EMPLOYEE_ID = e.MANAGER_ID
           )
         )
       ) as XML
  from HR.DEPARTMENTS d, HR.COUNTRIES c, HR.LOCATIONS l
 where d.LOCATION_ID = l.LOCATION_ID
   and l.COUNTRY_ID  = c.COUNTRY_ID
/