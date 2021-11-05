import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashbordComponent } from './pages/dashbord/dashbord.component';
import { IndexComponent } from './pages/index/index.component';

const routes: Routes = [  
  {
    path: '', 
    component: IndexComponent
  },
  {
    path: 'home', 
    component: DashbordComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
