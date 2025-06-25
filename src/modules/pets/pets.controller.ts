import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { PetsService } from './pets.service';
import { CreatePetDto } from './dto/create-pet.dto';
import { UpdatePetDto } from './dto/update-pet.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Pets')
@Controller('pets')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class PetsController {
  constructor(private readonly petsService: PetsService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new pet' })
  @ApiResponse({ status: 201, description: 'Pet created successfully' })
  create(@Body() createPetDto: CreatePetDto, @Request() req) {
    return this.petsService.create(createPetDto, req.user.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all pets (Admin) or user pets' })
  @ApiResponse({ status: 200, description: 'Pets retrieved successfully' })
  findAll(@Request() req) {
    if (req.user.role === 'admin') {
      return this.petsService.findAll();
    }
    return this.petsService.findByOwner(req.user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get pet by ID' })
  @ApiResponse({ status: 200, description: 'Pet retrieved successfully' })
  @ApiResponse({ status: 404, description: 'Pet not found' })
  findOne(@Param('id') id: string, @Request() req) {
    const userId = req.user.role === 'admin' ? undefined : req.user.id;
    return this.petsService.findOne(id, userId);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update pet by ID' })
  @ApiResponse({ status: 200, description: 'Pet updated successfully' })
  @ApiResponse({ status: 404, description: 'Pet not found' })
  update(@Param('id') id: string, @Body() updatePetDto: UpdatePetDto, @Request() req) {
    const userId = req.user.role === 'admin' ? undefined : req.user.id;
    return this.petsService.update(id, updatePetDto, userId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete pet by ID' })
  @ApiResponse({ status: 200, description: 'Pet deleted successfully' })
  @ApiResponse({ status: 404, description: 'Pet not found' })
  remove(@Param('id') id: string, @Request() req) {
    const userId = req.user.role === 'admin' ? undefined : req.user.id;
    return this.petsService.remove(id, userId);
  }
}