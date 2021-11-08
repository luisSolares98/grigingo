import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  opciones= {
    home: false,
    desafios: false,
    premios: false,
    clasificacion: false
  };
  @Input() opcion: string  = "home";
  constructor() { 

  }

  ngOnInit(): void {
    if (this.opcion == 'home') {
      this.opciones.home = true;
    }
    if (this.opcion == 'desafios') {
      this.opciones.desafios = true;
    }
    if (this.opcion == 'premios') {
      this.opciones.premios = true;
    }
    if (this.opcion == 'clasificacion') {
      this.opciones.clasificacion = true;
    }
  }

}
