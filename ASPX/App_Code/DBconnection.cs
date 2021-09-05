using System.Data;
using System.Data.SqlClient;
using System;

namespace DatabaseConnection
{
    public class SetDatabase
    {
        static string constr = "server=121.254.168.116; uid=raonica; password=hanulsinpock1270; database=dbraonica";
        static SqlConnection setdatabase;
        
        // DataTable을 리턴해준다. 직접적인 쿼리는 지양하기 때문에 StoredProcedure를 이용한다.
        public static DataTable SetDatabaseReader(string query)
        {
            setdatabase = new SqlConnection(constr);
            DataTable dataTable = new DataTable();

            try
            {
                // Database Open
                setdatabase.Open();

                // 
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = setdatabase;
                sqlCommand.CommandText = query;
				sqlCommand.CommandType = CommandType.Text;

                // SqlDataReader
                SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();

                // DataTable Load
                dataTable.Load(sqlDataReader);

                return dataTable;
            }
            catch (SqlException se)
            {
                throw;
            }
            finally
            {
                setdatabase.Close();
            }
        }
    }
}