<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListaSalario.aspx.cs" Inherits="SistGestPessoa.ListagemSalario" Debug="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Lista de Salário
    </h2>
    <div style="margin-left: 40px">
       
        <asp:Label ID="Label1" runat="server" Text="Nome:"></asp:Label>      
        <asp:TextBox ID="txbNome" runat="server" Width="232px" ReadOnly="True"></asp:TextBox> 

        <asp:Label ID="Label2" runat="server" Text="Salário:"></asp:Label>      
        <asp:TextBox ID="txbSalario" runat="server" Width="225px" required="true"></asp:TextBox> 

         <br />

        <asp:Button class="btn_default" ID="btCalcularRecalcular" runat="server" Text="Calcular/Recalcular" Font-Bold="True" ForeColor="#0066FF" Width="162px" OnClick="btCalcularRecalcular_Click" />
        <asp:TextBox ID="TextIdHidder" runat="server" Visible="false"></asp:TextBox><br />
        <br />
     
    </div>
    <div style="margin-left: 40px">
  
       <asp:GridView ID="GridViewPessoaSalario" class="gridDefault" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" Width="822px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="idpessoasalario">
           <AlternatingRowStyle BackColor="#CCCCCC" />
           <Columns>
               <asp:CommandField ShowSelectButton="True" />
               <asp:BoundField DataField="idpessoasalario" HeaderText="idpessoasalario" SortExpression="idpessoasalario" InsertVisible="False" ReadOnly="True" />
              <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />
               <asp:BoundField DataField="Nome do cargo" HeaderText="Nome do cargo" SortExpression="Nome do cargo" />
              <asp:BoundField DataField="Salário" HeaderText="Salário" SortExpression="Salário" />
           </Columns>
           <FooterStyle BackColor="#CCCCCC" />
           <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
           <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
           <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
           <SortedAscendingCellStyle BackColor="#F1F1F1" />
           <SortedAscendingHeaderStyle BackColor="#808080" />
           <SortedDescendingCellStyle BackColor="#CAC9C9" />
           <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
  
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:dbSistemaGestaoPessoaConnectionString %>" 
            DeleteCommand="DELETE FROM [pessoa_salario] WHERE [ID] = @original_ID AND [pessoa_id] = @original_pessoa_id AND [salario] = @original_salario" 
            InsertCommand="INSERT INTO [pessoa_salario] ([pessoa_id], [salario]) VALUES (@pessoa_id, @salario)" OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT ps.ID AS idpessoasalario, p.NOME AS Nome, ps.salario AS Salário, c.NOME AS 'Nome do cargo' FROM pessoa_salario AS ps INNER JOIN Pessoa AS p ON p.ID = ps.pessoa_id INNER JOIN Cargo AS c ON c.ID = p.CARGO_ID" 
            UpdateCommand="UPDATE [pessoa_salario] SET [pessoa_id] = @pessoa_id, [salario] = @salario WHERE [ID] = @original_ID AND [pessoa_id] = @original_pessoa_id AND [salario] = @original_salario">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_pessoa_id" Type="Int32" />
                <asp:Parameter Name="original_salario" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="pessoa_id" Type="Int32" />
                <asp:Parameter Name="salario" Type="Decimal" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="pessoa_id" Type="Int32" />
                <asp:Parameter Name="salario" Type="Decimal" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_pessoa_id" Type="Int32" />
                <asp:Parameter Name="original_salario" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </div>

</asp:Content>
