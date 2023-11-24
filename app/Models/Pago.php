<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pago extends Model
{
    use HasFactory;

    protected $fillable  = [
        "prestamo_id",
        "plan_pago_id",
        "cliente_id",
        "nro_cuota",
        "monto",
        "interes",
        "dias_mora",
        "monto_mora",
        "monto_total",
        "fecha_pago",
    ];

    public function prestamo()
    {
        return $this->belongsTo(Prestamo::class, 'prestamo_id');
    }

    public function plan_pago_id()
    {
        return $this->belongsTo(PlanPago::class, 'plan_pago_id_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }
}
