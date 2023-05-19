using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace SistGestPessoa
{
    public partial class Gerenciar : Page
    {
        string setConnection = ConfigurationManager.ConnectionStrings["dbSistemaGestaoPessoaConnectionString"].ConnectionString;
        SqlConnection con;
        SqlCommand command;
        SqlCommand command2;
        SqlDataAdapter adapter;
        DataTable dt;
        
        protected void Page_Load(object sender, EventArgs e)
        {

        } 
        
        public void ClearFields() 
        {
            txbNome.Text = "";
            txbUsuario.Text = "";
            txbEmail.Text = "";
            txbTelefone.Text = "";
            txbCep.Text = "";
            txbEndereco.Text = "";
            txbCidade.Text = "";
            txbPais.Text = "";
            txbDataNascimento.Text = "";
            DropDownListCargo.SelectedValue = null;
        }
        protected void btCadastrar_Click(object sender, EventArgs e)
        {
            try 
            {
                var id = 0;
                using (con = new SqlConnection(setConnection))
                {
                    con.Open();
                    command = new SqlCommand("INSERT INTO Pessoa (NOME, USUARIO, EMAIL, TELEFONE, CEP, ENDERECO, CIDADE, PAIS, DATA_NASCIMENTO, CARGO_ID) values" +
                    "('" + txbNome.Text + "','" + txbUsuario.Text + "','" + txbEmail.Text + "','" + txbTelefone.Text + "'," +
                    "'" + txbCep.Text + "','" + txbEndereco.Text + "','" + txbCidade.Text + "','" + txbPais.Text + "'," +
                    "'" + txbDataNascimento.Text + "','" + DropDownListCargo.SelectedValue + "') SELECT SCOPE_IDENTITY()", con);
                    id = Convert.ToInt32(command.ExecuteScalar());
                    command = new SqlCommand("INSERT INTO pessoa_salario (pessoa_id,salario) SELECT p.ID, c.SALARIO FROM Pessoa p inner join Cargo c on p.CARGO_ID = c.ID AND p.ID ="+id, con);
                    command.ExecuteNonQuery();
                    Response.Write("<script> alert('Cadastrado com Sucesso!')</script>");
                    ClearFields();
                    con.Close();
                    GridViewPessoa.DataBind();
                }
            }
            catch (Exception )
            {
                Response.Write("<script> alert('Erro ao Cadastrar!')</script>");
            }          
        }
 
        protected void DropDownListCargo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void btBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                using (con = new SqlConnection(setConnection))
                {
                    con.Open();
                    command = new SqlCommand("SELECT FROM Pessoa WHERE NOME LIKE '%@NOME%' ", con);
                    command.Parameters.AddWithValue("@NOME", txbNome.Text);
                    command.ExecuteNonQuery();
                    adapter = new SqlDataAdapter(command);
                    dt = new DataTable();
                    adapter.Fill(dt);                   
                    GridViewPessoa.DataSource = dt;
                    GridViewPessoa.DataBind();

                }
            }
            catch (Exception)
            {
                Response.Write("<script> alert('Erro ao Buscar!')</script>");
            }
        }
        protected void btCancelar_Click(object sender, EventArgs e)
        {
            ClearFields();
            btCadastrar.Visible = true;
            Response.Redirect("~/Gerenciar.aspx");
        }

        protected void btDeletar_Click(object sender, EventArgs e)
        {
            try
            {
                using (con = new SqlConnection(setConnection))
                {
                    con.Open();
                    command = new SqlCommand("DELETE FROM pessoa_salario WHERE pessoa_id = @ID", con);
                    command.Parameters.AddWithValue("@ID", int.Parse(TextIdHidder.Text));
                    command.ExecuteNonQuery();
                    con.Close();
                }
                using (con = new SqlConnection(setConnection))
                {
                    con.Open();                 
                    command = new SqlCommand("DELETE FROM Pessoa WHERE ID = @ID", con);
                    command.Parameters.AddWithValue("@ID", int.Parse(TextIdHidder.Text));
                    command.ExecuteNonQuery();
                    Response.Write("<script> alert('Excluido com Sucesso!')</script>");
                    ClearFields();
                    con.Close();
                    GridViewPessoa.DataBind();
                }
            }
            catch (Exception)
            {
                Response.Write("<script> alert('Erro ao Excluir!')</script>");
            }
        }

        protected void btAtualizar_Click(object sender, EventArgs e)
        {
            try
            {             
                using (con = new SqlConnection(setConnection))
                {
                 
                    con.Open();
                    command = new SqlCommand($"UPDATE Pessoa SET NOME=@NONE, USUARIO=@USUARIO, EMAIL=@EMAIL, TELEFONE=@TELEFONE, CEP=@CEP, ENDERECO=@ENDERECO, CIDADE=@CIDADE, PAIS=@PAIS, DATA_NASCIMENTO=@DATA_NASCIMENTO, CARGO_ID=@CARGO_ID WHERE ID=@ID", con);

                    command.Parameters.AddWithValue("@ID", int.Parse(TextIdHidder.Text));
                    command.Parameters.AddWithValue("@NONE", txbNome.Text);
                    command.Parameters.AddWithValue("@USUARIO", txbUsuario.Text);
                    command.Parameters.AddWithValue("@EMAIL", txbEmail.Text);
                    command.Parameters.AddWithValue("@TELEFONE", txbTelefone.Text);
                    command.Parameters.AddWithValue("@CEP", txbCep.Text);
                    command.Parameters.AddWithValue("@ENDERECO", txbEndereco.Text);
                    command.Parameters.AddWithValue("@CIDADE", txbCidade.Text);
                    command.Parameters.AddWithValue("@PAIS", txbPais.Text);
                    command.Parameters.AddWithValue("@DATA_NASCIMENTO", txbDataNascimento.Text);
                    command.Parameters.AddWithValue("@CARGO_ID", int.Parse(DropDownListCargo.SelectedValue));
                    
                    command.ExecuteNonQuery();

                    con.Close();
                }
                using (con = new SqlConnection(setConnection))
                {
                    con.Open();
                                      
                    var idCargo = int.Parse(DropDownListCargo.SelectedValue);
                    var idPessoa = int.Parse(TextIdHidder.Text);
                    var salario = BuscarCargo(idCargo);

                    command = new SqlCommand($"UPDATE pessoa_salario SET salario = {salario} WHERE pessoa_salario.pessoa_id = {idPessoa}", con);
                    command.ExecuteNonQuery();
                    Response.Write("<script> alert('Atualizado com Sucesso!')</script>");
                    ClearFields();
                    con.Close();
                    GridViewPessoa.DataBind();
                }
            }
            catch (Exception)
            {
                Response.Write("<script> alert('Erro ao Atualizar!')</script>");
            }
        }

        public decimal BuscarCargo(int idCargo)
        {

            decimal salario = 0;
            try
            {
                command2 = new SqlCommand($"select salario from Cargo c where c.ID={idCargo}", con);             
                salario = Convert.ToInt32(command2.ExecuteScalar());
            }
            catch (Exception)
            {
                Response.Write("<script> alert('Erro ao Buscar!')</script>");

            }
            return salario;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextIdHidder.Text = GridViewPessoa.SelectedRow.Cells[1].Text;
            txbUsuario.Text = GridViewPessoa.SelectedRow.Cells[3].Text;
            txbNome.Text = GridViewPessoa.SelectedRow.Cells[2].Text;
            txbEmail.Text = GridViewPessoa.SelectedRow.Cells[4].Text;
            txbTelefone.Text = GridViewPessoa.SelectedRow.Cells[5].Text;
            txbCep.Text = GridViewPessoa.SelectedRow.Cells[6].Text;
            txbEndereco.Text = GridViewPessoa.SelectedRow.Cells[7].Text;
            txbCidade.Text = GridViewPessoa.SelectedRow.Cells[8].Text;
            txbPais.Text = GridViewPessoa.SelectedRow.Cells[9].Text;
            txbDataNascimento.Text = GridViewPessoa.SelectedRow.Cells[10].Text;
            DropDownListCargo.SelectedItem.Text = GridViewPessoa.SelectedRow.Cells[11].Text;
            btCadastrar.Visible = false;
                     
        }
    }
}