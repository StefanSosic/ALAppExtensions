namespace Microsoft.SubscriptionBilling;

using Microsoft.Purchases.Document;

pageextension 8071 "Purch Invoice Subform" extends "Purch. Invoice Subform"
{
    actions
    {

        addlast("Related Information")
        {
            action(ShowBillingLines)
            {
                ApplicationArea = All;
                Caption = 'Billing Lines';
                Image = AllLines;
                ToolTip = 'Show Billing Lines.';
                Scope = Repeater;
                Enabled = IsConnectedToBillingLine;

                trigger OnAction()
                begin
                    ContractsGeneralMgt.ShowBillingLinesForDocumentLine(Rec."Document Type", Rec."Document No.", Rec."Line No.");
                end;
            }
            action("Usage Data")
            {
                ApplicationArea = All;
                Caption = 'Usage Data';
                Image = DataEntry;
                Scope = Repeater;
                ToolTip = 'Shows the related usage data.';

                trigger OnAction()
                var
                    UsageDataBilling: Record "Usage Data Billing";
                    UsageBasedDocTypeConv: Codeunit "Usage Based Doc. Type Conv.";
                begin
                    UsageDataBilling.FilterOnDocumentTypeAndDocumentNo(UsageBasedDocTypeConv.ConvertPurchaseDocTypeToUsageBasedBillingDocType(Rec."Document Type"), Rec."Document No.");
                    UsageDataBilling.SetRange("Document Line No.", Rec."Line No.");
                    Page.RunModal(Page::"Usage Data Billings", UsageDataBilling);
                end;
            }

        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        IsConnectedToBillingLine := Rec.IsLineAttachedToBillingLine();
    end;

    var
        ContractsGeneralMgt: Codeunit "Contracts General Mgt.";
        IsConnectedToBillingLine: Boolean;
}
