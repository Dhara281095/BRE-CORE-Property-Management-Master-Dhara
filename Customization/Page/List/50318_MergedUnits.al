page 50318 "Merged Units List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Merged Units";
    Caption = 'Merged Units';
    UsageCategory = Lists;
    CardPageId = 50317;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Merged Unit ID"; Rec."Merged Unit ID")
                {
                    ApplicationArea = All;
                }

                field("Property ID"; Rec."Property ID")
                {
                    ApplicationArea = All;
                }

                field("Property Name"; Rec."Property Name") // Custom Field
                {
                    ApplicationArea = All;

                }

                field("Unit ID"; Rec."Unit ID")
                {
                    ApplicationArea = All;
                }

                field("Merged Unit Name"; Rec."Merged Unit Name")
                {
                    ApplicationArea = All;
                }

                field("Unit Size"; Rec."Unit Size")
                {
                    ApplicationArea = All;
                }

                // field("Market Rate per Square"; Rec."Market Rate per Square")
                // {
                //     ApplicationArea = All;
                // }

                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                }

                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = All;
                }

                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }

                field("Splitting Status"; Rec."Spliting Status")
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Open Card")
            {
                ApplicationArea = All;
                Caption = 'Open Card';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Merged Units Card", Rec);
                end;
            }
        }
    }
}
