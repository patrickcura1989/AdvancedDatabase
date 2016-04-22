--
-- Using XML Views to execute XQuery expressions on relational data
--
select *
  from XMLTable
       (
         'for $d in fn:collection("oradb:/OE/DEPARTMENT_XML")/Department[Name="Executive"]
          return $d'
       )
/
select *
  from XMLTable
       (
         'for $d in fn:collection("oradb:/OE/DEPARTMENT_XML")/Department[EmployeeList/Employee/LastName="Grant"]/Name
          return $d'
       )
/