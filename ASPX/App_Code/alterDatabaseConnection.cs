using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// alterDatabaseConnection의 요약 설명입니다.
/// </summary>
namespace alterDatabaseConnection
{
    public class SetDatabaseConnection
    {
        private static SqlConnectionStringBuilder sqlConnectionStringBuilder;
        private static SqlConnection sqlConnection;

        private SetDatabaseConnection()
        {
            //
            // TODO: 여기에 생성자 논리를 추가합니다.
            //
        }

        public static bool databaseOpen()
        {
            try
            {
                sqlConnectionStringBuilder = new SqlConnectionStringBuilder();
                sqlConnectionStringBuilder["Data Source"] = "121.254.168.116";
                sqlConnectionStringBuilder["Initial Catalog"] = "dbmenistream";
                sqlConnectionStringBuilder["User ID"] = "menistream";
                sqlConnectionStringBuilder["Password"] = "menistream@2460";

                sqlConnection = new SqlConnection();
                sqlConnection.ConnectionString = sqlConnectionStringBuilder.ConnectionString;
                sqlConnection.Open();

                return true;
            }
            catch (SqlException sqlException)
            {
                return false;
            }
        }

        public static DataTable databaseReader(string query)
        {
            try
            {
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandText = query;

                SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                DataTable dataTable = new DataTable();
                dataTable.Load(sqlDataReader);

                sqlDataReader.Dispose();
                sqlDataReader.Close();
                sqlCommand.Dispose();
                sqlCommand.Clone();

                return dataTable;
            }
            catch (SqlException sqlException)
            {
                throw;
            }
        }

        public static void databaseClose()
        {
            sqlConnection.Close();
        }
    }
}
