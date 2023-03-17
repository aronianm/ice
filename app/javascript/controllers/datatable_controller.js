import { Controller } from "@hotwired/stimulus"
import DataTable from "datatables.net-bs5"
DataTable.ext.classes.sTable = 'text-sm text-left text-gray-500 text-gray-400'
DataTable.ext.classes.sFilterInput = 'bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500'
export default class extends Controller {
  connect() {

    $(this.element).DataTable({
      retrieve: true,
      paging: false,
      aaSorting: []
    })
  }
}