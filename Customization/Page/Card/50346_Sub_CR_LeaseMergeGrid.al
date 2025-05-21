page 50346 "CR Sub Lease Merged Units Card"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "CR Sub Lease Merged Units";
    Caption = 'Sub Lease Merged Unit Card';


    layout
    {
        area(content)
        {
            repeater(Group)
            {


                field("ID"; rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Merge Unit ID"; Rec."Merge Unit ID")
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

    // trigger OnOpenPage()
    // begin
    //     // Apply a filter to prevent any records from being loaded by default
    //     Rec.SetRange("Merge Unit ID", '0');  // Replace with an appropriate field and condition to filter out records.
    //     CurrPage.Update(false);  // Refresh the page after applying the filter
    // end;

}






