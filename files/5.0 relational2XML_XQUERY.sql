-- Simple XQuery showing how fn:collection can be used to generate 
-- a simple XML document from each row in a relational table.
--
Select Xmlserialize(Document Column_Value As Clob Indent Size=2)
  From Xmltable (
         'fn:collection("oradb:/HR/DEPARTMENTS")'
       )
 Where Rownum < 3
/
-- Using XQuery and fn:collection to create XML documents 
-- from relational tables.
select *
  from XMLTable
       (
         'for $d in fn:collection("oradb:/HR/DEPARTMENTS")/ROW, 
		          $l in fn:collection("oradb:/HR/LOCATIONS")/ROW,
		          $c in fn:collection("oradb:/HR/COUNTRIES")/ROW
	   					where $d/LOCATION_ID = $l/LOCATION_ID
								and $l/COUNTRY_ID = $c/COUNTRY_ID 
	   					return
	   						<Department DepartmentId= "{$d/DEPARTMENT_ID/text()}" >
									<Name>{$d/DEPARTMENT_NAME/text()}</Name>
									<Location>
		  							<Address>{$l/STREET_ADDRESS/text()}</Address>
		  							<City>{$l/CITY/text()}</City>
		  							<State>{$l/STATE_PROVINCE/text()}</State>
		  							<Zip>{$l/POSTAL_CODE/text()}</Zip>
		  							<Country>{$c/COUNTRY_NAME/text()}</Country>
									</Location>
									<EmployeeList>
									{
		   							for $e in fn:collection("oradb:/HR/EMPLOYEES")/ROW,
		  	 								$m in fn:collection("oradb:/HR/EMPLOYEES")/ROW,
			 									$j in fn:collection("oradb:/HR/JOBS")/ROW
		   									where $e/DEPARTMENT_ID = $d/DEPARTMENT_ID
		      								and $j/JOB_ID = $e/JOB_ID
													and $m/EMPLOYEE_ID = $e/MANAGER_ID
		   										return
		   											<Employee employeeNumber="{$e/EMPLOYEE_ID/text()}" >
															<FirstName>{$e/FIRST_NAME/text()}</FirstName>
															<LastName>{$e/LAST_NAME/text()}</LastName>
															<EmailAddress>{$e/EMAIL/text()}</EmailAddress>
															<Telephone>{$e/PHONE_NUMBER/text()}</Telephone>
															<StartDate>{$e/HIRE_DATE/text()}</StartDate>
															<JobTitle>{$j/JOB_TITLE/text()}</JobTitle>
															<Salary>{$e/SALARY/text()}</Salary>
															<Manager>{$m/LAST_NAME/text(), ", ", $m/FIRST_NAME/text()}</Manager>
		      										<Commission>{$e/COMMISSION_PCT/text()}</Commission>
		    										</Employee>
		 							}
		 							</EmployeeList>
	    					</Department>'
	    	) D
  where rownum < 3
/          