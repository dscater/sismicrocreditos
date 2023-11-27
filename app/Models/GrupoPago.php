<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GrupoPago extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "grupo_id",
        "grupal_plan_pago_id",
        "cliente_id",
        "nro_cuota",
        "monto",
        "interes",
        "dias_mora",
        "monto_mora",
        "monto_total",
        "fecha_pago",
    ];
}
