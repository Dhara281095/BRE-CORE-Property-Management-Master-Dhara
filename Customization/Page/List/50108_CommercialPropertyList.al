page 50108 "Commercial Property List"
{
    PageType = List;
    SourceTable = "Property Registration";
    ApplicationArea = All;
    Caption = 'Commercial Property List';
    UsageCategory = Administration;

    // CardPageId = 31;

    SourceTableView = where("Property Classification" = const('Commercial'));


    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Property ID"; Rec."Property ID")
                {
                    ApplicationArea = All;
                    Caption = 'Property ID';
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                    Caption = 'Property Name';
                }
                field("Property Type"; Rec."Property Classification")
                {
                    ApplicationArea = All;
                    Caption = 'Property Type';
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        // Apply filter directly without showing the filter UI
        Rec.SetRange("Property Classification", 'Commercial');
    end;

}
