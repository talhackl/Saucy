using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using E_CommerceDbFirst.Models;
using System.Data.Entity;
using System.IO;
using System.Threading.Tasks;
using System.Diagnostics;

namespace E_CommerceDbFirst.Controllers.Api
{
    
    public class ItemsController : ApiController
    {
        //Initializing DataBase Nd Constructor Initializing
        data_Base db;
        public ItemsController()
        {
            db = new data_Base();
        }

        //Get All The Items From DataBase
        [HttpGet]
        public IHttpActionResult get()
        {
            var data = db.getItems();
            if (data == null)
            {
                return BadRequest();
            }
            return Ok(data);
        }

        //[HttpGet]
        //public IHttpActionResult getByItemsId(string itemsId)
        //{
        //    var items = db.Items.Where(m => itemsId.Contains(m.ItemId));
        //}






        //Get THe Items from DataBase On The Base of Choosen CatName
        [HttpGet]
        public IHttpActionResult getByCat(string categories)
        {
            if (categories == null)
            {
                return Redirect("/items/index");
            }

            var data = db.getItemByCatName(categories);
            if (data != null)
            {
                return Ok(data);
            }
            return Redirect("/items/index");
        }

        //Get THe Items from DataBase On The Base of Choosen CatName
        [HttpGet]
        public IHttpActionResult getByIngredient(string ingredients)
        {
            if (ingredients == null)
            {
                return Redirect("/items/idex");
            }
            var data = db.getItemsByIngredientName(ingredients);
            if (data != null)
            {
                return Ok(data);
            }
            return Redirect("/items/index");
        }

        //Get The Specific Item on the base of ItemId
        [HttpGet]
        public IHttpActionResult GetById(int id)
        {
            if (id < 1)
            {
                return Redirect("/items/index");
            }
            var data = db.getItemById(id);
            if (data == null)
            {
                return Content(HttpStatusCode.BadRequest, "Data DoesNot Exist");
            }
            return Ok(data);
        }

        //Saving New Item in DataBase

        public Task<IHttpActionResult> Post()
        {
            Item item = new Item();
            string[] array = new string[3];
            List<string> savedFilePath = new List<string>();
            string rootPath = HttpContext.Current.Server.MapPath("~/Images");
            var provider = new MultipartFormDataStreamProvider(rootPath);
            var task = Request.Content.ReadAsMultipartAsync(provider).
                ContinueWith<IHttpActionResult>(t =>
                {
                    int i = 0;
                    foreach (var key in provider.FormData.AllKeys)
                    {
                        foreach (var val in provider.FormData.GetValues(key))
                        {
                            array[i] = val;
                            i++;
                        }
                    }
                    foreach (MultipartFileData file in provider.FileData)
                    {
                        try
                        {

                            string name = file.Headers.ContentDisposition.FileName.Replace("\"", "");
                            string newFileName = Guid.NewGuid() + Path.GetExtension(name);
                            File.Move(file.LocalFileName, Path.Combine(rootPath, newFileName));
                            Uri baseuri = new Uri(Request.RequestUri.AbsoluteUri.Replace(Request.RequestUri.PathAndQuery, string.Empty));
                            string fileRelativePath = "~/Images/" + newFileName;
                            Uri fileFullPath = new Uri(baseuri, VirtualPathUtility.ToAbsolute(fileRelativePath));
                            savedFilePath.Add(fileFullPath.ToString());
                            item.ImageUrl = fileFullPath.ToString();
                            item.Name = array[0];
                            item.Price = Convert.ToDecimal(array[1]);
                            item.CategoriesId = Convert.ToInt32(array[2]);
                            db.saveItem(item.Name, item.Price, item.ImageUrl, item.CategoriesId);
                            db.SaveChanges();
                        }
                        catch (Exception ex)
                        {
                            string message = ex.Message;
                        }

                    }
                    return Ok("Succeeded");
                });
            return task;

        }

        //Deleting The Item From DataBase
        [HttpPut]
        public IHttpActionResult deleteItem(int id)
        {
            try
            {
                db.deleteItem(id);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest();
            }
            
        }

    }
}
