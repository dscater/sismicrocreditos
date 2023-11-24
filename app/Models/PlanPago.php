<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanPago extends Model
{
    use HasFactory;

    protected $fillable = [
        "prestamo_id",
        "nro_cuota",
        "saldo_inicial",
        "capital",
        "interes",
        "saldo",
        "cuota",
        "cancelado",
        "fecha_pago",
    ];

    public function prestamo()
    {
        return $this->belongsTo(Prestamo::class, 'prestamo_id');
    }
}
