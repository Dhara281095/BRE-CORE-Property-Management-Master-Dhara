page 50331 "Sub Merged Units Card"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Sub Merged Units";
    Caption = 'Sub Merged Unit Card';

    layout
    {
        area(content)
        {
            repeater(Group)
            {



                field("Merged Unit ID"; Rec."Merged Unit ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }



                field("Unit ID"; Rec."Unit ID")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Visible = true;


                }




                field("Base Unit of Measure"; rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Editable = false;
                }

                field("Unit Size"; Rec."Unit Size")
                {
                    ApplicationArea = All;
                }

                field("Market Rate per Square"; Rec."Market Rate per Square")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }

                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                }


                field("Single Unit Name"; Rec."Single Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                }




            }





        }
    }
}




