<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanPago extends Model
{
    use HasFactory;

    protected $fillable = [
        "prestamo_id",
        "plan_pago_id",
        "nro_cuota",
        "saldo_inicial",
        "capital",
        "interes",
        "saldo",
        "cuota",
        "cancelado",
        "fecha_pago",
    ];
}
