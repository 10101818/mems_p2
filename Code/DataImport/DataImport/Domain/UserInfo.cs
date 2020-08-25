
using System;
using System.Collections.Generic;
using System.Data;
using DataImport.Domain;

namespace DataImport.Domain
{
    public class UserInfo : EntityInfo
    {
        public string Name { get; set; }
        public string Mobile { get; set; }
       
        public UserInfo() 
        {
        }       
    }
}
