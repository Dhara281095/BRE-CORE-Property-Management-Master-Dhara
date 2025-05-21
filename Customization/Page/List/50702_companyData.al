page 50712 "testpagelist"
{
    PageType = List;
    SourceTable = testData;
    ApplicationArea = All;
    Caption = 'Company Data';
    CardPageId = 50701;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company ID"; Rec."Company ID")
                {
                    ApplicationArea = All;
                }

                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Company Logo"; Rec."Company Logo")
                {
                    ApplicationArea = All;
                    Editable = true;
                    trigger OnValidate()
                    begin
                        // Add custom logic for logo upload if needed
                    end;
                }
                field("Tenant id"; Rec."Tenant id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Environment Name"; Rec."Environment Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(UploadLogo)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // Implement logic for uploading logo
                    MESSAGE('Logo uploaded successfully.');
                end;
            }
        }
    }
}
