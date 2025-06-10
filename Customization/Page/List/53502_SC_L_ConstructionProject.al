page 53502 "Construction Project List"
{
    PageType = List;
    SourceTable = "Construction Project";
    ApplicationArea = All;
    Caption = 'Construction Project :List';
    UsageCategory = Lists;
    CardPageId = 53501;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Project ID."; Rec."Project ID")
                {
                    ApplicationArea = All;
                    Caption = 'Project ID';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Project Name';
                }
                field("Project Location"; Rec."Project Location")
                {
                    ApplicationArea = All;
                    Caption = 'Project Location';
                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Project Start Date';
                }
                field("Project End Date"; Rec."Project End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Project End Date';
                }
                field("Project Status"; Rec."Project Status")
                {
                    ApplicationArea = All;
                    Caption = 'Project Status';
                }
            }
        }
    }
}