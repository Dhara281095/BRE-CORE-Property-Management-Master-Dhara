page 50303 "Primary Classification List"
{
    PageType = List;
    SourceTable = "Primary Classification";
    ApplicationArea = All;
    Caption = 'Primary Classification List';
    UsageCategory = Lists;
    CardPageId = 50301;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification Name';
                }
            }
        }
    }


    // Link to open the card page for detailed editing
    // DrillDownPageId = "Primary Classification Card";
    // EditPageId = "Primary Classification Card";
}
