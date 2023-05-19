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
    public partial class ListagemSalario : System.Web.UI.Page 
    {
        string setConnection = ConfigurationManager.ConnectionStrings["dbSistemaGestaoPessoaConnectionString"].ConnectionString;
        SqlConnection con;
        SqlCommand command;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextIdHidder.Text = GridViewPessoaSalario.SelectedRow.Cells[1].Text;
            txbNome.Text = GridViewPessoaSalario.SelectedRow.Cells[2].Text;
            txbSalario.Text = GridViewPessoaSalario.SelectedRow.Cells[4].Text;
        }

        protected void btCalcularRecalcular_Click(object sender, EventArgs e)
        {
            try
            {
                using (con = new SqlConnection(setConnection))
                {
                    con.Open();
                    command = new SqlCommand("UPDATE pessoa_salario SET SALARIO=@SALARIO WHERE ID=@ID", con);
                    command.Parameters.AddWithValue("@ID", int.Parse(TextIdHidder.Text));
                    command.Parameters.AddWithValue("@SALARIO", decimal.Parse(txbSalario.Text));
                    
                    command.ExecuteNonQuery();

                    Response.Write("<script> alert('Realizado com Sucesso!')</script>");
                    con.Close();
                    GridViewPessoaSalario.DataBind();
                }
            }
            catch (Exception)
            {
                Response.Write("<script> alert('Erro na Atualização!')</script>");
            }
        }
    }
}