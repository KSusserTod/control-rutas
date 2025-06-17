using control_rutas_API.Models;
using control_rutas_API.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace control_rutas_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CiudadController : ControllerBase
    {
        private readonly ApplicationDbContext context;

        public CiudadController(ApplicationDbContext context)
        {
            this.context = context;
        }
        [HttpGet("id")]
        public async Task<ActionResult<Resultado>> GetById(int id)
        {
            try 
            {
                var ciudad = await context.ciudad.Where(x => x.Id == id).FirstOrDefaultAsync();

                var resultado = new Resultado
                {
                    Exito = true,
                    Mensaje = "exito",
                    Data = ciudad
                };

                return resultado;
            }
            catch(Exception ex)
            {
                var resultadoError = new Resultado
                {
                    Exito = false,
                    Mensaje = ex.Message
                };
                return resultadoError;
            }          
        }
        [HttpGet]
        public async Task<ActionResult<Resultado>> GetAll()
        {
            try
            {
                var ciudad = context.ciudad.ToList();

                var resultado = new Resultado
                {
                    Exito = true,
                    Mensaje = "Peticion completada con exito",
                    Data = ciudad
                };

                return resultado;
            }
            catch (Exception ex)
            {
                var resultadoError = new Resultado
                {
                    Exito = false,
                    Mensaje = ex.Message,
                };

                return resultadoError;
            }
        }
    }
}
