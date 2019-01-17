/*SELECT		ROW_NUMBER() OVER (ORDER BY id) RecordID,
			Affinity_Cold__c = Replace(Affinity_Cold__c, ',', ''), 
            Affinity_Industry_Type__c = Replace(Affinity_Industry_Type__c, ',', ''), 
            CitationSector__c = Replace(CitationSector__c, ',', ''), 
            City = Replace(City, ',', ''), 
            Company = Replace(Company, ',', ''), 
            Country = Replace(Country, ',', ''), 
            Email = Replace(Email, ',', ''), 
            FirstName = Replace(FirstName, ',', ''), 
            FT_Employees__c = FT_Employees__c, 
            Id = Replace(Id, ',', ''), 
            LastName = Replace(LastName, ',', ''), 
            MobilePhone = Replace(MobilePhone, ',', ''), 
            Name = Replace(Name, ',', ''),
            Other_Phone__c = Replace(Other_Phone__c, ',', ''), 
            Phone = Replace(Phone, ',', ''), 
            Position__c = Replace(Position__c, ',', ''), 
            PostalCode = Replace(PostalCode, ',', ''), 
            Salesforce_Id__c = Replace(Salesforce_Id__c, ',', ''), 
            Salutation = Replace(Salutation, ',', ''), 
            Sector__c = Replace(Sector__c, ',', ''), 
            SIC2007_Code2__c, 
            SIC2007_Code3__c, 
            SIC2007_Code__c,
            SIC2007_Description2__c = Replace(cast(SIC2007_Description2__c as nvarchar(max)), ',', ''), 
            SIC2007_Description3__c = Replace(cast(SIC2007_Description3__c as nvarchar(max)), ',', ''), 
            SIC2007_Description__c = Replace(cast(SIC2007_Description__c as nvarchar(max)), ',', ''), 
            [State] = Replace([State], ',', ''), 
            [Status] = Replace([Status], ',', ''), 
            Replace(Replace(Replace(Replace(Street, ',', ''), CHAR(10)+CHAR(13), ''), CHAR(10), ''), CHAR(13), '') as street
            
            INTO
            #Snap

FROM Salesforce..Lead*/

SELECT *
FROM #Snap
WHERE RecordID between 700001 and 800000