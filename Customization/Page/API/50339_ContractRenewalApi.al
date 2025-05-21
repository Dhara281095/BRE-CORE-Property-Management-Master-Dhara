page 50339 "contractRenewalApi"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Contract Renewal";
    APIPublisher = 'RealestateDev';
    APIGroup = 'contracts';
    APIVersion = 'v2.0';
    EntityName = 'contractRenewal';    // Singular, PascalCase
    EntitySetName = 'contractRenewals'; // Plural, PascalCase
    Caption = 'Contract Renewal API';
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("SystemId"; Rec.SystemId) // Add SystemId explicitly to the layout
            {
                Caption = 'System Identifier';
            }
            field("Id"; Rec.Id) { }
            field("OwnersName"; Rec."Owner's Name") { }
            field("LessorsName"; Rec."Lessor's Name") { }
            field("LessorsEmiratesID"; Rec."Lessor's Emirates ID") { }
            field("LicenseNo"; Rec."License No.") { }
            field("LicensingAuthority"; Rec."Licensing Authority") { }
            field("LessorsEmail"; Rec."Lessor's Email") { }
            field("LessorsPhone"; Rec."Lessor's Phone") { }
            field("ContractID"; Rec."Contract ID") { }
            field("ContractStartDate"; Rec."Contract Start Date") { }
            field("ContractEndDate"; Rec."Contract End Date") { }
            field("ContractAmount"; Rec."Contract Amount") { }
            field("UnitID"; Rec."Unit ID") { }
            field("UnitName"; Rec."Unit Name") { }
            field("PropertyID"; Rec."Property ID") { }
            field("PropertyName"; Rec."Property Name") { }
            field("RenewalContractStatus"; Rec."Renewal Contract Status") { }
            field("TenantFullName"; Rec."Tenant Full Name") { }
            field("ContractTenor"; Rec."Contract Tenor") { }
            field("ApprovalForRenewal"; Rec."Approval For Renewal") { }
            field("ProposalID"; Rec."Proposal ID") { }
            field("EjariName"; Rec."Ejari Name") { }
            field("PropertyClassification"; Rec."Property Classification") { }
            field("PropertyType"; Rec."Property Type") { }
            field("AnnualRentAmount"; Rec."Annual Rent Amount") { }
            field("ContractDate"; Rec."Contract Date") { }
            field("BaseUnitOfMeasure"; Rec."Base Unit of Measure") { }
            field("UnitSqFeet"; Rec."Unit Sq. Feet") { }
            field("GracePeriod"; Rec."Grace Period") { }
            field("GraceStartDate"; Rec."Grace Start Date") { }
            field("GraceEndDate"; Rec."Grace End Date") { }
            field("TenantID"; Rec."Tenant ID") { }
            field("EmiratesID"; Rec."Emirates ID") { }
            field("ContactNumber"; Rec."Contact Number") { }
            field("EmailAddress"; Rec."Email Address") { }
            field("PaymentFrequency"; Rec."Payment Frequency") { }
            field("PaymentMethod"; Rec."Payment Method") { }
            field("CreatedBy"; Rec."Created By") { }
            field("MergeUnitID"; Rec."Merge Unit ID") { }
            field("RentAmount"; Rec."Rent Amount") { }
            field("TenantLicenseNo"; Rec."Tenant_License No.") { }
            field("TenantLicensingAuthority"; Rec."Tenant_Licensing Authority") { }
            field("SecurityDepositAmount"; Rec."Security Deposit Amount") { }
            field("UnitNumber"; Rec."Unit Number") { }
            field("MakaniNumber"; Rec."Makani Number") { }
            field(Emirate; Rec.Emirate) { }
            field(Community; Rec.Community) { }
            field("DEWANumber"; Rec."DEWA Number") { }
            field("PropertySize"; Rec."Property Size") { }
            field("NoOfInstallments"; Rec."No of Installments") { }
            field(UnitID1; Rec.UnitID) { }
            field(OriginalContractID; Rec."Original Contract ID") { }
        }
    }
}
