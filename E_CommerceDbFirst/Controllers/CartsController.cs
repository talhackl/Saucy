using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
//using Microsoft.AspNet.Identity.Owin;

namespace E_CommerceDbFirst.Controllers
{
    public class CartsController : Controller
    {
        [AllowAnonymous]
        // GET: /Carts/
        public ActionResult Index()
        {
            return View();
        }
	}
}