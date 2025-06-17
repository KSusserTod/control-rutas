using control_rutas_API.Models;
using control_rutas_API.Models.DTOs;
using control_rutas_API.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.EntityFrameworkCore;

namespace control_rutas_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeeController : ControllerBase
    {
        private readonly ApplicationDbContext context;

        public EmployeeController(ApplicationDbContext context)
        {
            this.context = context;
        }
        [HttpGet("id")]
        public async Task<ActionResult<Resultado>> GetById(int id)
        {
            try
            {
                var employee = await context.employees.Where(x => x.Id == id).FirstOrDefaultAsync();

                var resultado = new Resultado
                {
                    Exito = true,
                    Mensaje = "exito",
                    Data = employee
                };

                return resultado;
            }
            catch (Exception ex)
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
                var employee = context.employees
                    .Where(e => e.Status == true).ToList();

                var resultado = new Resultado
                {
                    Exito = true,
                    Mensaje = "Petición completada con exito",
                    Data = employee
                };

                return resultado;

            }
            catch(Exception ex)
            {
                var resultadoError = new Resultado
                {
                    Exito = false,
                    Mensaje = "Hubo un error al procesar la solicitud: " + ex.Message,
                    Data = ""
                };

                return StatusCode(500, resultadoError);
            }
        }

        [HttpGet("GetByCity/{id}")]
        public async Task<ActionResult<Resultado>> GetByCityId(int id)
        {
            try
            {
                var employee = context.employees
                    .Where(e => e.Status == true)
                    .Where(a => a.IdCiudad == id).ToList();

                var resultado = new Resultado
                {
                    Exito = true,
                    Mensaje = "Petición completada con exito",
                    Data = employee
                };

                return resultado;

            }
            catch (Exception ex)
            {
                var resultadoError = new Resultado
                {
                    Exito = false,
                    Mensaje = "Hubo un error al procesar la solicitud: " + ex.Message,
                    Data = ""
                };

                return StatusCode(500, resultadoError);
            }
        }


        [HttpPost]
        public async Task<ActionResult<Resultado>> Post(EmployeeDTO employeeDTO)
        {
            var employee = new Employee
            {
                Nombre = employeeDTO.Nombre,
                ApellidoPaterno = employeeDTO.ApellidoPaterno,
                ApellidoMaterno = employeeDTO.ApellidoMaterno,
                IdCiudad = employeeDTO.IdCiudad,
                Status = employeeDTO.Status,
                FechaNacimiento = employeeDTO.FechaNacimiento,
                Sueldo = employeeDTO.Sueldo,
            };
            var res = new Resultado();
            try
            {
                context.employees.Add(employee);
                context.SaveChanges();
                res.Exito = true;
                res.Mensaje = "Empleado creado con exito";
                res.Data = employee;
            }
            catch(Exception ex)
            {
                res.Exito = false;
                res.Mensaje = ex.Message;
            }

            return Ok(res);
        }

        [HttpPut("Update/{id}")]
        public async Task<ActionResult<Resultado>> Put(EmployeeDTO employeeDTO, int id)
        {
            var emp = context.employees.Find(id);
            if (emp == null)
            {
                return NotFound();
            }

            emp.Nombre = employeeDTO.Nombre;
            emp.ApellidoPaterno = employeeDTO.ApellidoPaterno;
            emp.ApellidoMaterno = employeeDTO.ApellidoMaterno;
            emp.IdCiudad = employeeDTO.IdCiudad;
            emp.Status = employeeDTO.Status;
            emp.FechaNacimiento = employeeDTO.FechaNacimiento;
            emp.Sueldo = employeeDTO.Sueldo;
            emp.FechaModificacion = DateTime.Now;
            

            var res = new Resultado();

            try
            {
                context.SaveChanges();
                res.Exito = true;
                res.Mensaje = "Empleado actualizado con exito";
                res.Data = null;
            }
            catch(Exception ex)
            {
                res.Exito = false;
                res.Mensaje = ex.Message;
            }

            return Ok(res);
        }

        [HttpPut("Delete/{id}")]
        public async Task<ActionResult<Resultado>> Delete(int id)
        {
            var emp = context.employees.Find(id);
            if (emp == null)
            {
                return NotFound();
            }
            
            emp.Status = false;
            emp.FechaModificacion = DateTime.Now;
            emp.FechaCancelacion = DateTime.Now;


            var res = new Resultado();

            try
            {
                context.SaveChanges();
                res.Exito = true;
                res.Mensaje = "Empleado elimnado con exito";
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
