namespace PropertyManagement.PropertyManagement;

report 50107 "Revenue Allocation"
{
    ApplicationArea = All;
    Caption = 'Revenue Allocation';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Revenue Allocation.xlsx';
    DefaultLayout = Excel;


    dataset
    {
        dataitem(TenancyContract; "Tenancy Contract")
        {
            column(Property_Name; "Property Name")
            {
            }
            column(Contract_ID; "Contract ID")
            {
            }
            column(Contract_Tenor; "Contract Tenor")
            {
            }
            column(Tenant_ID; "Tenant ID")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Contract_Start_Date; "Contract Start Date")
            {
            }
            column(Contract_End_Date; "Contract End Date")
            {
            }
            column(Grace_Period; "Grace Period")
            {
            }
            column(Rent_Amount; "Rent Amount")
            {
            }
            column(Annual_Rent_Amount; "Annual Rent Amount")
            {
            }
            column(Owner_s_Name; "Owner's Name")
            {
            }

            trigger OnAfterGetRecord()
            var
                StartDateIsInRange: Boolean;
                EndDateIsInRange: Boolean;
            begin
                // Check if Contract Start Date or Contract End Date is in the specified range
                StartDateIsInRange := ("Contract Start Date" >= CustomStartDate) and ("Contract Start Date" <= CustomEndDate);
                EndDateIsInRange := ("Contract End Date" >= CustomStartDate) and ("Contract End Date" <= CustomEndDate);

                if not (StartDateIsInRange or EndDateIsInRange) then
                    CurrReport.SKIP(); // Skip record if neither date is in range
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(CustomStartDate; CustomStartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom Start Date';
                    }
                    field(CustomEndDate; CustomEndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Custom End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CustomStartDate: Date;
        CustomEndDate: Date;

}
