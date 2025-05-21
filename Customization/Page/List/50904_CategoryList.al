page 50904 "Category List"
{
    PageType = List;
    SourceTable = "Category Type";
    ApplicationArea = All;
    Caption = 'Category List';
    UsageCategory = Lists;
    CardPageId = 50905;

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
                field("Primary Item Type"; Rec."Primary Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Item';
                    TableRelation = "Primary Item";
                    // Display the Primary Classification description
                    Lookup = true; // Enable lookup to Primary Classification
                }
                field("Category Types"; Rec."Category Types")
                {
                    ApplicationArea = All;
                    Caption = 'Category Types';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Caption = 'New';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.Init();
                    Rec.Insert(true);
                    CurrPage.Update();
                end;
            }
        }
    }


}
