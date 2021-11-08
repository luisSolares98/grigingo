import { Usuario } from './usuario';


export interface RespuestaTop {
    status: number;
    mensaje: string;
    usuario: Usuario;
}