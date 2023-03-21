import { Controller } from "@hotwired/stimulus"
import DataTable from "datatables.net-bs5"
DataTable.ext.classes.sTable = 'text-sm text-left text-gray-500 text-gray-400'
DataTable.ext.classes.sFilterInput = 'bg-gray-50 border border-gray-300  text-sm rounded-lg focus:border-blue-500 block w-full p-2.5 text-gray'

export default class extends Controller {
  connect() {

    $(this.element).DataTable({
      retrieve: true,
      paging: false,
      aaSorting: []
    })
  }
}