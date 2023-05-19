<%@ Page Title="Gerenciar Pessoa" Language="C#" MasterPageFile="~/Site.Master" Debug="true" AutoEventWireup="true" CodeBehind="Gerenciar.aspx.cs" Inherits="SistGestPessoa.Gerenciar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Cadastrar Pessoa</h2>
   
    
    <div style="margin-left: 40px">

        <asp:Label ID="Label1" runat="server" Text="Nome:"></asp:Label>      
        <asp:TextBox ID="txbNome" runat="server" Width="400px" required="true"></asp:TextBox>&nbsp;
        <asp:Button ID="Button1" runat="server" OnClick="btBuscar_Click" Text="Buscar" Visible="false" />
        <asp:TextBox ID="TextIdHidder" runat="server" Visible="false"></asp:TextBox> <br/><br/>
        <asp:Label ID="Label2" runat="server" Text="Usuário:"></asp:Label>                               
        <asp:TextBox ID="txbUsuario" runat="server" Width="200px" required="true"></asp:TextBox>         
        <asp:Label ID="Label3" runat="server" Text="E-mail:"></asp:Label>        
        <asp:TextBox ID="txbEmail" runat="server" Width="384px" required="true"></asp:TextBox><br/><br/> 
        <asp:Label ID="Label4" runat="server" Text="Telefone:"></asp:Label>                              
        <asp:TextBox ID="txbTelefone" runat="server" Width="208px" required="true"></asp:TextBox>       
        <asp:Label ID="Label5" runat="server" Text="Cep:"></asp:Label>      
        <asp:TextBox ID="txbCep" runat="server" Width="100px" required="true"></asp:TextBox>      
        <asp:Label ID="Label6" runat="server" Text="Endereço:"></asp:Label>                         
        <asp:TextBox ID="txbEndereco" runat="server" Width="350px" required="true"></asp:TextBox><br/><br/> 
        <asp:Label ID="Label7" runat="server" Text="Cidade:"></asp:Label>      
        <asp:TextBox ID="txbCidade" runat="server" Width="163px" required="true"></asp:TextBox>      
        <asp:Label ID="Label8" runat="server" Text="País:"></asp:Label>                               
        <asp:TextBox ID="txbPais" runat="server" Width="115px" required="true"></asp:TextBox>                                                                                                              
        <asp:Label ID="Label9" runat="server" Text="Data de Nascimento:"></asp:Label>                 
        <asp:TextBox ID="txbDataNascimento" runat="server" Width="162px" required="true"></asp:TextBox>    
        <asp:Label ID="Label10" runat="server" Text="Cargo:"></asp:Label> 
        <asp:DropDownList ID="DropDownListCargo" runat="server" OnSelectedIndexChanged="DropDownListCargo_SelectedIndexChanged">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem Value="1">Estagiário</asp:ListItem>
            <asp:ListItem Value="2">Técnico</asp:ListItem>
            <asp:ListItem Value="3">Analista</asp:ListItem>
            <asp:ListItem Value="4">Coordenador</asp:ListItem>
            <asp:ListItem Value="5">Gerente</asp:ListItem>
        </asp:DropDownList>
        <br />        
        <asp:Button class="btn_default" ID="btCadastrar" runat="server" Text="Cadastrar"  OnClick="btCadastrar_Click" Font-Bold="True" />      
        &nbsp;
        <asp:Button class="btn_default" ID="btAtualizar" runat="server"  Text="Atualizar" OnClick="btAtualizar_Click" Font-Bold="True" ForeColor="#009933"/>     
        &nbsp;
        <asp:Button class="btn_default" ID="btDeletar" runat="server" Text="Apagar" OnClick="btDeletar_Click" Font-Bold="True" ForeColor="Red" OnClientClick="return confirm('Deseja apagar?');" />   
        &nbsp;
        <asp:Button class="btn_default" ID="btCancelar" runat="server" Text="Cancelar" OnClick="btCancelar_Click" Font-Bold="True" ForeColor="#FF9900" /> 
        <br />

   </div>
    <hr />  
  <div class="gridDefault">
  
      <asp:GridView ID="GridViewPessoa" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Nº" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="1177px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
          <AlternatingRowStyle BackColor="#CCCCCC" />
          <Columns>
              <asp:CommandField ShowSelectButton="True" />
              <asp:BoundField DataField="Nº" HeaderText="Nº" InsertVisible="false" ReadOnly="True" SortExpression="Nº"/>
              <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />
              <asp:BoundField DataField="Usuário" HeaderText="Usuário" SortExpression="Usuário" />
              <asp:BoundField DataField="E-mail" HeaderText="E-mail" SortExpression="E-mail" />
              <asp:BoundField DataField="Telefone" HeaderText="Telefone" SortExpression="Telefone" />
              <asp:BoundField DataField="Cep" HeaderText="Cep" SortExpression="Cep" />
              <asp:BoundField DataField="Endereço" HeaderText="Endereço" SortExpression="Endereço" />
              <asp:BoundField DataField="Cidade" HeaderText="Cidade" SortExpression="Cidade" />
              <asp:BoundField DataField="País" HeaderText="País" SortExpression="País" />
              <asp:BoundField DataField="Data de Nascimento" HeaderText="Data de Nascimento" SortExpression="Data de Nascimento" DataFormatString="{0:dd/MM/yyyy}" />
              <asp:BoundField DataField="Cargo" HeaderText="Cargo" SortExpression="Cargo" />
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
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbSistemaGestaoPessoaConnectionString %>" SelectCommand="select p.ID as Nº, p.nome as Nome, p.USUARIO as Usuário, p.EMAIL as 'E-mail', p.TELEFONE as Telefone, p.CEP as Cep, p.ENDERECO as Endereço, p.CIDADE as Cidade, p.PAIS as País, p.DATA_NASCIMENTO as 'Data de Nascimento', c.NOME as Cargo from [Pessoa] p 
inner join [Cargo] c on p.cargo_id = c.id"></asp:SqlDataSource>
    
   </div>
</asp:Content>