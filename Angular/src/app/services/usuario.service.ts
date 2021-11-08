import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment.prod';
import { ConfigService } from './config.service';
import { RespuestaTop } from '../../models/Respuesta';
@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  url = environment.urlApi;
  constructor(private _http: HttpClient, private sConfig: ConfigService) { }
  insert(username: string, password: string) {
    const headers = this.sConfig.getHeaders();

    let obj = {
      "nick": username,
      "password": password
    }
    const params = JSON.stringify(obj);
    return this._http.post<RespuestaTop>(this.url + "usuario" , params, { headers });
  }
  login(username: string, password: string) {
    const headers = this.sConfig.getHeaders();
    let obj = {
      "nick": username,
      "password": password
    }
    const params = JSON.stringify(obj);
    return this._http.post<RespuestaTop>(this.url + "login", params, { headers });
  }
}
