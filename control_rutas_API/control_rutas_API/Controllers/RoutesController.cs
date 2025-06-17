using control_rutas_API.Models;
using control_rutas_API.Models.DTOs;
using control_rutas_API.Services;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace control_rutas_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoutesController : ControllerBase
    {
        private readonly ApplicationDbContext context;

        public RoutesController(ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpGet]
        public async Task<ActionResult<Resultado>> GetAll()
        {
            try
            {
                var routes = context.routes
                    .Where(e => e.Estatus == true).ToList();

                var resultado = new Resultado
                {
                    Exito = true,
                    Mensaje = "Petición completada con exito",
                    Data = routes
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
        [HttpGet("GetByCity/{id}")]
        public async Task<ActionResult<Resultado>> GetByCityId(int id)
        {
            try
            {
                var routes = context.routes
                    .Where(e => e.Estatus == true)
                    .Where(a=>a.IdCiudad == id).ToList();

                var resultado = new Resultado
                {
                    Exito = true,
                    Mensaje = "Petición completada con exito",
                    Data = routes
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

        [HttpPost]
        public async Task<ActionResult<Resultado>> Post(RoutesDTO routesDTO)
        {
            var routes = new Routes
            {
                IdChofer = routesDTO.IdChofer,
                IdCiudad = routesDTO.IdCiudad,
                Nombre = routesDTO.Nombre,
                Capacidad = routesDTO.Capacidad,
                Estatus = routesDTO.Estatus,
                TipoServicio = routesDTO.TipoServicio,          
            };
            var res = new Resultado();

            try
            {
                context.routes.Add(routes);
                context.SaveChanges();
                res.Exito = true;
                res.Mensaje = "Ruta creada con exito";
                res.Data = routes;
            }
            catch (Exception ex)
            {
                res.Exito = false;
                res.Mensaje = ex.Message;
            }
            return Ok(res);
        }

        [HttpPut("Update/{id}")]
        public async Task<ActionResult<Resultado>> Put(RoutesDTO routesDTO, int id)
        {
            var rout = context.routes.Find(id);
            if (rout == null)
            {
                return NotFound();
            }

            rout.IdChofer = routesDTO.IdChofer;
            rout.IdCiudad = routesDTO.IdCiudad;
            rout.Nombre = routesDTO.Nombre;
            rout.Capacidad = routesDTO.Capacidad;
            rout.Estatus = routesDTO.Estatus;
            rout.TipoServicio = routesDTO.TipoServicio;
            rout.FechaModificacion = DateTime.Now;

            var res = new Resultado();

            try
            {
                context.SaveChanges();
                res.Exito = true;
                res.Mensaje = "Ruta actualizada con exito";
                res.Data = null;
            }
            catch (Exception ex)
            {
                res.Exito = false;
                res.Mensaje = ex.Message;
            }
            return Ok(res);
        }

        [HttpPut("Delete/{id}")]
        public async Task<ActionResult<Resultado>> Delete(int id)
        {
            var rout = context.routes.Find(id);
            if (rout == null)
            {
                return NotFound();
            }

            rout.Estatus = false;
            rout.FechaCancelacion = DateTime.Now;
            rout.FechaModificacion = DateTime.Now;

            var res = new Resultado();

            try
            {
                context.SaveChanges();
                res.Exito = true;
                res.Mensaje = "Ruta eliminada con exito";
                res.Data = null;
            }
            catch (Exception ex)
            {
                res.Exito = false;
                res.Mensaje = ex.Message;
            }
            return Ok(res);
        }
    }
}
