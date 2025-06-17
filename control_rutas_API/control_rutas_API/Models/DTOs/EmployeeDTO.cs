namespace control_rutas_API.Models.DTOs
{
    public class EmployeeDTO
    {
        public int IdCiudad { get; set; }
        public string Nombre { get; set; } = "";
        public string ApellidoPaterno { get; set; } = "";
        public string ApellidoMaterno { get; set; } = "";
        public DateTime FechaNacimiento { get; set; }
        public float Sueldo { get; set; }
        public bool Status { get; set; }
    }
}
