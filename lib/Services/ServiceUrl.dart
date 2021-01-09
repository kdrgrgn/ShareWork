class ServiceUrl {
  static final String baseUrlShareWork = "https://api.share-work.com";

  final String login = baseUrlShareWork + "/Account/login";

  final String register = baseUrlShareWork + "/Account/Signup";

  final String getBuro = baseUrlShareWork + "/Office/getoffice";

  final String getPersonal = baseUrlShareWork + "/Personel/GetPersonelList";

  final String getDepartment =
      baseUrlShareWork + "/Department/getdepartmentlist";

  final String getCustomers = baseUrlShareWork + "/Customer/getcustomerlist";

  final String foldersNew =
      baseUrlShareWork + "/File/GetFilesByUserIdForDirectory";

  final String filesUpload = baseUrlShareWork + "/File/UploadFiles";

  final String deleteFileDirectory =
      baseUrlShareWork + "/File/DeleteMultiFileAndDirectory";

  final String fileRename = baseUrlShareWork + "/File/FileRename";

  final String createFolder = baseUrlShareWork + "/File/CreateDirectory";

  final String renameDirectory = baseUrlShareWork + "/File/RenameDirectory";

  final String addNewCustomer = baseUrlShareWork + "/Customer/addcustomer";

  final String getPluginList = baseUrlShareWork + "/Plugin/getpluginlist";

  final String getAddUserPlugin = baseUrlShareWork + "/Plugin/adduserplugin";

  final String getCustomeList = baseUrlShareWork + "/Customer/getcustomerlist";

  final String getProjectList = baseUrlShareWork + "/Project/GetProjects";

  final String getAllFamilyTaskList =
      baseUrlShareWork + "/Family/GetAllFamilyTaskList";

  final String getFamilyPersonWithId =
      baseUrlShareWork + "/Family/GetFamilyPersonWithId";

  final String getFamily = baseUrlShareWork + "/Family/GetFamily";

  final String getFamilyPersonTaskListRepeat = baseUrlShareWork + "/Family/GetFamilyPersonTaskListRepeat";

  final String insertFamilyPersonTask =
      baseUrlShareWork + "/Family/InsertFamilyPersonTask";

  final String multipleInsertFamilyPersonTask =
      baseUrlShareWork + "/Family/InsertFamilyPersonTaskMultiple";

  final String getFamilyShopItemList =
      baseUrlShareWork + "/Family/GetFamilyShopItemList";

  final String getFamilyShopOrderList =
      baseUrlShareWork + "/Family/GetFamilyShopOrderList";

  final String insertFamilyShopOrder =
      baseUrlShareWork + "/Family/InsertFamilyShopOrder";

  final String insertFamilyShopOrderMultiple =
      baseUrlShareWork + "/Family/InsertFamilyShopOrderMultiple";

  final String getFamilyBudgetItemList =
      baseUrlShareWork + "/Family/GetFamilyBudgetList";

  final String insertFamilyBudgetItem =
      baseUrlShareWork + "/Family/InsertFamilyBudgetItem";

  final String insertFamilyGift =
      baseUrlShareWork + "/Family/InsertFamilyGift";

  final String getFamilyGiftList =
      baseUrlShareWork + "/Family/GetFamilyGiftList";

  final String createFamily =
      baseUrlShareWork + "/Family/InsertFamily";

  final String addPerson =
      baseUrlShareWork + "/Family/AddPerson";


  final String getFamilyPersonTaskMessageList =
      baseUrlShareWork + "/Family/GetFamilyPersonTaskMessageList";


  final String insertFamilyPersonTaskMessage =
      baseUrlShareWork + "/Family/InsertFamilyPersonTaskMessage";


  final String editFamilyPersonTaskDetails =
      baseUrlShareWork + "/Family/EditFamilyPersonTaskDetails";

  final String editFamilyPersonTaskDetailsWithPersonId =
      baseUrlShareWork + "/Family/EditFamilyPersonTaskDetailsWithPersonId";


  final String editFamilyShopOrder =
      baseUrlShareWork + "/Family/EditFamilyShopOrder";


  final String deleteFamilyShopOrder =
      baseUrlShareWork + "/Family/DeleteFamilyShopOrder";


  final String buyFamilyShopOrder =
      baseUrlShareWork + "/Family/BuyFamilyShopOrder";


  final String editFamilyPersonTaskPersonId =
      baseUrlShareWork +"/Family/EditFamilyPersonTaskPersonId";


}
