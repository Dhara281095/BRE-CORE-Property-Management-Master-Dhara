page 50332 "Sub Lease Merged Units Card"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Sub Lease Merged Units";
    Caption = 'Sub Lease Merged Unit Card';


    layout
    {
        area(content)
        {
            repeater(Group)
            {


                field("Proposal ID"; rec."Proposal ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Merge  Unit ID"; Rec."Merge Unit ID")
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



                // field("Get Data"; Rec."Get Data")
                // {
                //     ApplicationArea = All;
                //     Editable = true;
                //     DrillDown = true; // Enables DrillDown behavior

                //     trigger OnDrillDown()
                //     var
                //         MergeSameSquareRec: Record "Merge SameSqure SubPage";
                //         SubLeaseMergeRec: Record "Sub Lease Merged Units";
                //     begin
                //         if Rec."Proposal ID" = 0 then
                //             Error('Proposal ID is missing.');

                //         // Fetch data from the Merge SameSqure SubPage table
                //         MergeSameSquareRec.SetRange("Proposal ID", Rec."Proposal ID");
                //         // MergeSameSquareRec.SetRange("MS_Unit ID", Rec."Unit ID");

                //         if MergeSameSquareRec.FindSet() then
                //             repeat
                //                 // Initialize and insert the fetched records
                //                 SubLeaseMergeRec.Init();
                //                 SubLeaseMergeRec."Proposal ID" := Rec."Proposal ID";
                //                 SubLeaseMergeRec."Merge Unit ID" := Rec."Merge Unit ID";
                //                 SubLeaseMergeRec."Unit ID" := Rec."Unit ID";
                //                 SubLeaseMergeRec."Year" := MergeSameSquareRec."MS_Year"; // Year
                //                 SubLeaseMergeRec."Per Day Rent" := MergeSameSquareRec."MS_Per Day Rent"; // Per Day Rent
                //                 SubLeaseMergeRec."Base Unit of Measure" := rec."Base Unit of Measure"; // Hardcoded for display
                //                 SubLeaseMergeRec."Unit Size" := Rec."Unit Size";
                //                 SubLeaseMergeRec."Market Rate per Square" := Rec."Market Rate per Square";
                //                 SubLeaseMergeRec."Single Unit Name" := Rec."Single Unit Name";

                //                 SubLeaseMergeRec.Insert(false); // Insert the record
                //             until MergeSameSquareRec.Next() = 0;

                //         Message('Data fetched successfully for Year and Per Day Rent.');
                //         CurrPage.Update();
                //     end;
                // }





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






