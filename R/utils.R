

css_styling <- function(){

  x <- ".fa.fa-question-circle.shinyhelper-icon {
      color: #749dbf
    }
    .font-weight-light {
      font-weight: 500 !important
    }
    .main-footer {
      font-weight: 600
    }
    .px-3 {
      margin-left: auto
    }
    .pt-2 {
      padding-top: 0.80rem !important;
    }
    .ml-auto {
      margin-left: 0px !important;
    }
    .btn-primary.focus,
    .btn-primary:focus {
      background-color:#749dbf;
      border-color:#749dbf;
    }
    .datepicker table tr td.active:active,
    .datepicker table tr td.active.active,
    .datepicker table tr td.active.highlighted:active,
    .datepicker table tr td.active.highlighted.active,
    .datepicker table tr td.active.active:hover {
      background-color:#749dbf;
      border-color:#749dbf;
    }
    select {
      background: url(data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0Ljk1IDEwIj48ZGVmcz48c3R5bGU+LmNscy0xe2ZpbGw6I2ZmZjt9LmNscy0ye2ZpbGw6IzQ0NDt9PC9zdHlsZT48L2RlZnM+PHRpdGxlPmFycm93czwvdGl0bGU+PHJlY3QgY2xhc3M9ImNscy0xIiB3aWR0aD0iNC45NSIgaGVpZ2h0PSIxMCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMiIgcG9pbnRzPSIxLjQxIDQuNjcgMi40OCAzLjE4IDMuNTQgNC42NyAxLjQxIDQuNjciLz48cG9seWdvbiBjbGFzcz0iY2xzLTIiIHBvaW50cz0iMy41NCA1LjMzIDIuNDggNi44MiAxLjQxIDUuMzMgMy41NCA1LjMzIi8+PC9zdmc+) no-repeat 95% 50%;
	    -moz-appearance: none;
	    -webkit-appearance: none;
	    appearance: none;
      height: 30px;
	    width: 50px;
	    padding: 5px;
    }
     "
  tags$style(x)
}
