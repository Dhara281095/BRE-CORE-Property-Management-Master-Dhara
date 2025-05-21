page 50336 "Contract Renewal List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Contract Renewal";
    Caption = 'Contract Renewal List';
    CardPageId = 50335;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Id"; rec.Id)
                {
                    ApplicationArea = All;
                }
                field("Contract ID"; rec."Contract ID")
                {
                    ApplicationArea = All;
                }
                field("Contract Start Date"; rec."Contract Start Date")
                {
                    ApplicationArea = All;
                }
                field("Contract End Date"; rec."Contract End Date")
                {
                    ApplicationArea = All;
                }
                field("Contract Amount"; rec."Contract Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit ID"; rec."Unit ID")
                {
                    ApplicationArea = All;
                }

                field("Merge Unit ID"; rec."Merge Unit ID")
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; rec."Unit Name")
                {
                    ApplicationArea = All;
                }
                field("Property ID"; rec."Property ID")
                {
                    ApplicationArea = All;
                }
                field("Property Name"; rec."Property Name")
                {
                    ApplicationArea = All;
                }
                field("Contract Status"; rec."Renewal Contract Status")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}