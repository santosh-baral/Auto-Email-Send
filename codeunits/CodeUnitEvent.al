codeunit 50102 EventMgt
{
    [EventSubscriber(ObjectType::CodeUnit, CodeUnit::"Sales-Post", 'OnAfterDeleteAfterPosting', '', false, false)]
    local procedure OnAfterDeleteAfterPosting(SalesHeader: Record "Sales Header"; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; CommitIsSuppressed: Boolean)
    var
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        EmailMsg: CodeUnit "Email Message";
        EmailObj: CodeUnit Email;
        SalesPostedTitle: Label 'The Sales Document %2 of Customer %1 has been posted.';
        SalesPostedMsg: Label 'Dear Manager<br><br>The Sales Document <font color="red"><strong>%2</strong></font> of Customer <strong>%1</strong> has been posted.<br> The total amount is <strong>%3</strong>. <br>The Posted Invoice Number is <strong>%4</strong>. <br> User ID <strong>%5</strong>';
    begin

        Recipients.Add('santoshbaral258@gmail.com');
        SalesInvoiceHeader.CalcFields("Amount Including VAT");
        Subject := StrSubstNo(SalesPostedTitle, SalesHeader."Sell-to Customer Name", SalesHeader."No.");
        Body := StrSubstNo(SalesPostedMsg, SalesHeader."Sell-to Customer Name", SalesHeader."No.", SalesInvoiceHeader."Amount Including VAT", SalesInvoiceHeader."No.", UserId);
        EmailMsg.Create(Recipients, Subject, Body, true);
        if EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default) then
            Message('Email is Send Successfully');
    end;
}