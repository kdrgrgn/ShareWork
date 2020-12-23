


class ServiceUrl{





   static final String baseUrlShareWork="https://api.share-work.com";



    final String LOGIN_SCAN = baseUrlShareWork
      + "/Account/login";

    final String GET_BURO = baseUrlShareWork
      + "/Office/getoffice";

    final String GET_PERSONAL_SCAN = baseUrlShareWork
      + "/Personel/GetPersonelList";

    final String GET_DEPARTMENT_SCAN = baseUrlShareWork
      + "/Department/getdepartmentlist";

    final String GET_CUSTOMERS_SCAN = baseUrlShareWork
      + "/Customer/getcustomerlist";

    final String FOLDERS_NEW = baseUrlShareWork
      + "/File/GetFilesByUserIdForDirectory";


    final String FILES_UPLOAD = baseUrlShareWork
      + "/File/UploadFiles";

    final String DELETE_FILE_DIRECTORY = baseUrlShareWork
      + "/File/DeleteMultiFileAndDirectory";


    final String FILE_RENAME = baseUrlShareWork
      + "/File/FileRename";


    final String CREATE_FOLDER = baseUrlShareWork
      + "/File/CreateDirectory";


    final String RENAME_DIRECTORY = baseUrlShareWork
      + "/File/RenameDirectory";

    final String  ADD_NEW_CUSTOMER = baseUrlShareWork
      + "/Customer/addcustomer";

    final String  GET_PLUG_IN_LIST = baseUrlShareWork
      + "/Plugin/getpluginlist";

    final String  GET_ADD_USER_PLUG_IN = baseUrlShareWork
      + "/Plugin/adduserplugin";

    final String  GET_CUSTOME_LIST = baseUrlShareWork
      + "/Customer/getcustomerlist";

    final String  GET_PROJECT_LIST = baseUrlShareWork
      + "/Project/GetProjects";
    final String  GET_All_FAMILY_TASK_LIST = baseUrlShareWork
      + "/Family/GetAllFamilyTaskList";
    final String  GET_FAMILY_PERSON_WITH_ID = baseUrlShareWork
      + "/Family/GetFamilyPersonWithId";
    final String  GET_FAMILY = baseUrlShareWork
      + "/Family/GetFamily";

}