page 50506 "Azure Detail List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AzureConfiguration;
    Caption = 'Azure Detail List';
    CardPageId = 50505;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }

                field("SAS URL"; Rec."SAS URL")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}